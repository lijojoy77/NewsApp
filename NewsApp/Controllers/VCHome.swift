import UIKit
import SDWebImage

class VCHome: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tblViewNewsList: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView! 

    var newsResponse: NewsResponse?
    var refreshControl = UIRefreshControl()
    var currentPage = 1 // Start from the first page
    var pageSize = 20
    var hasMoreData = true
    var isLoadingData = false
    var isLoadingMoreData = false // Track if a load more operation is in progress
    let globalFunctions = GlobalFunctions.shared
    var country = "us"
    var category = ""

    private enum CellIdentifier {
        static let homeCell = "homeCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadNews()
    }

    private func setupUI() {
        txtSearch.delegate = self
        setupCustomNavigationBar(title: "All News", leftButtonImageName: "", leftButtonSelector: #selector(goBack), rightButtonImageName: "icon-filter", rightButtonSelector: #selector(selectCategory))
        tblViewNewsList.register(UINib(nibName: "TVCHomeCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.homeCell)
        tblViewNewsList.dataSource = self
        tblViewNewsList.delegate = self
        tblViewNewsList.rowHeight = 90
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tblViewNewsList.refreshControl = refreshControl
        txtSearch.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
    }

    @objc private func goBack() {
       
    }
    
    @objc private func selectCategory() {
        let filterList = FilterList()
        filterList.modalPresentationStyle = .popover

        // Set the desired width and height
        let width: CGFloat = UIScreen.main.bounds.width - 20
        let height: CGFloat = UIScreen.main.bounds.height - 100

        filterList.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

        // Pass the currently selected category and country values
        filterList.selectedCategoryValueName = category.lowercased()
        filterList.selectedCountryValueName = country.uppercased()

        if let popoverController = filterList.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            popoverController.delegate = self
        }

        // Set a closure to handle the selected category and country
        filterList.selectedCategory = { [weak self] selectedCategory, selectedCountry in
            self?.country = selectedCountry ?? ""
            self?.category = selectedCategory ?? ""
            self?.currentPage = 1
            self?.loadNews()
        
            // Set the navigation bar title to the selected category
            self?.navigationItem.title = selectedCategory?.capitalized ?? "All News"
            
            // Dismiss the category selection popup
            self?.dismiss(animated: true, completion: nil)
        }

        // Present the category selection popup
        present(filterList, animated: true, completion: nil)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    @objc private func refreshData(_ sender: UIRefreshControl) {
        // Perform the refresh action here
        currentPage = 1 // Reset to the first page when refreshing
        pageSize = 20 // Reset pageSize
        hasMoreData = true // Reset hasMoreData
        loadNews()
    }

    @objc private func searchTextChanged() {
        // Get the search text from the txtSearch field
        if let searchText = txtSearch.text {
            currentPage = 1 // Reset to the first page when searching
            pageSize = 20 // Reset pageSize
            hasMoreData = true // Reset hasMoreData
            loadNews(search: searchText)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder() // Hide the keyboard
            return true
        }

    private func loadNews(search: String = "", completion: (() -> Void)? = nil) {
        isLoadingData = true // Set isLoadingData to true while loading data
        loader.startAnimating() // Start the loader animation

        let webService = WebService()
        let apiUrl = URL(string: "\(globalFunctions.baseUrl)country=\(country)&category=\(category)&page=\(currentPage)&q=\(search)\(globalFunctions.apiKey)")!
      //  print("apiurl:", apiUrl)
        webService.loadService(url: apiUrl) { [weak self] (result: Result<NewsResponse, Error>) in
            guard let self = self else { return }

            self.isLoadingData = false // Set isLoadingData to false when data loading is complete
            DispatchQueue.main.async {
                self.loader.stopAnimating() // Stop the loader animation
            }

            switch result {
            case .success(let newsResponse):
                if self.currentPage == 1 {
                    // Clear existing data if it's the first page
                    self.newsResponse = newsResponse
                } else if let newArticles = newsResponse.articles, !newArticles.isEmpty {
                    // Append new articles to the existing list
                    self.newsResponse?.articles?.append(contentsOf: newArticles)
                } else {
                    // No more results, stop pagination
                    self.hasMoreData = false
                }

                DispatchQueue.main.async {
                    self.tblViewNewsList.reloadData()
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing() // End the refresh on error
                    } // End the refresh when data is loaded
                    completion?() // Call completion handler when data loading is complete
                }

            case .failure(let error):
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
                completion?()
            }
        }
    }

}

extension VCHome: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsResponse = newsResponse,
              let articles = newsResponse.articles,
              indexPath.row < articles.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.homeCell, for: indexPath) as? TVCHomeCell else {
            return UITableViewCell()
        }

        let article = articles[indexPath.row]
        configureCell(cell, with: article)
        return cell
    }

    
    func configureCell(_ cell: TVCHomeCell, with article: Article) {
        cell.lblHeader.text = article.title
        cell.lblHour.text = globalFunctions.timeAgoSinceDate(dateString: article.publishedAt)
        cell.lblChannel.text = article.source.name
  
        if let imageUrl = article.urlToImage {
                // Load and cache the image asynchronously on the main queue
                DispatchQueue.main.async {
                    cell.imgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"), options: [], completed: { image, error, cacheType, imageURL in
                        if cacheType == SDImageCacheType.none {
                            cell.imgView.alpha = 0
                            UIView.animate(withDuration: 0.8, animations: {
                                cell.imgView.alpha = 1
                            })
                        } else {
                            cell.imgView.alpha = 1
                        }
                    })
                }
            } else {
                cell.imgView.image = UIImage(named: "placeholder")
            }
    }

  

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedArticle = newsResponse?.articles?[indexPath.row] {
            // Instantiate the VCHomeDetail view controller from the XIB
            let detailVC = VCHomeDetail(nibName: "VCHomeDetail", bundle: nil)

            // Pass the selected article to the detail view controller
            detailVC.selectedArticle = selectedArticle

            // Present the detail view controller
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        // Check if a previous load more operation is not in progress and there is more data to load
        if !isLoadingMoreData && hasMoreData && offsetY > contentHeight - height {
            isLoadingMoreData = true
            currentPage += 1
            loadNews() { [weak self] in
                self?.isLoadingMoreData = false // Reset the flag when the data loading is complete
            }
        }
    }
}

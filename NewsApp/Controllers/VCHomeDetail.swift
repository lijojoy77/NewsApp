//
//  VCHomeDetail.swift
//  NewsApp
//
//  Created by Lijo Joy on 14/09/2023.
//

import UIKit
import SDWebImage

class VCHomeDetail: UIViewController {
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var imgViewTop: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblChannel: UILabel!
    @IBOutlet weak var backgrndView: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var selectedArticle: Article?
    let globalFunctions = GlobalFunctions.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Check if selectedArticle is not nil
        if let article = selectedArticle {
            setupUI(with: article)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.view.setNeedsLayout()
    }
    
    private func setupUI(with article: Article) {
        setupNavigationBar(with: article.title)
        populateUI(with: article)
        addCornerRadius(to: backgrndView)
    }

    private func setupNavigationBar(with title: String) {
        setupCustomNavigationBar(title: title, leftButtonImageName: "icon-chevron-left-large", leftButtonSelector: #selector(goBack), rightButtonImageName: "", rightButtonSelector: #selector(selectCategory))
    }

    private func populateUI(with article: Article) {
        lblHeader.text = article.title
        lblHour.text = globalFunctions.timeAgoSinceDate(dateString: article.publishedAt)
        lblChannel.text = article.source.name
        lblDescription.text = article.description
        
        if let imageUrl = article.urlToImage {
            imgViewTop.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"), options: [], completed: { [weak self] _, _, cacheType, _ in
                if cacheType == .none {
                    self?.animateImageFadeIn()
                }
            })
        }
    }
    
    private func addCornerRadius(to view: UIView) {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }

    @objc private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func selectCategory() {
        
    }

    private func animateImageFadeIn() {
        UIView.animate(withDuration: 0.8) {
            self.imgViewTop.alpha = 1
        }
    }
}

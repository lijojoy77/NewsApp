//
//  FilterList.swift
//  NewsApp
//
//  Created by Lijo Joy on 16/09/2023.
//

import UIKit

class FilterList: UITableViewController {
    
    enum Section: Int {
        case categories, countries
        
        static var count: Int { return Section.countries.rawValue + 1 }
        
        var title: String {
            switch self {
            case .categories: return "Select Category"
            case .countries: return "Select Country"
            }
        }
    }
    
    var categories: [String: String] = [
        "Business": "business",
        "Technology": "technology",
        "Entertainment": "entertainment",
        "General": "general",
        "Health": "health",
        "Science": "science",
        "Sports": "sports"
    ]
    
    var countries: [String: String] = [
        "United Arab Emirates": "AE",
        "Argentina": "AR",
        "Austria": "AT",
        "Australia": "AU",
        "Belgium": "BE",
        "Bulgaria": "BG",
        "Brazil": "BR",
        "Canada": "CA",
        "Switzerland": "CH",
        "China": "CN",
        "Colombia": "CO",
        "Cuba": "CU",
        "Czech Republic": "CZ",
        "Germany": "DE",
        "Egypt": "EG",
        "France": "FR",
        "United Kingdom": "GB",
        "Greece": "GR",
        "Hong Kong": "HK",
        "Hungary": "HU",
        "Indonesia": "ID",
        "Ireland": "IE",
        "Israel": "IL",
        "India": "IN",
        "Italy": "IT",
        "Japan": "JP",
        "South Korea": "KR",
        "Lithuania": "LT",
        "Latvia": "LV",
        "Morocco": "MA",
        "Mexico": "MX",
        "Malaysia": "MY",
        "Nigeria": "NG",
        "Netherlands": "NL",
        "Norway": "NO",
        "New Zealand": "NZ",
        "Philippines": "PH",
        "Poland": "PL",
        "Portugal": "PT",
        "Romania": "RO",
        "Serbia": "RS",
        "Russia": "RU",
        "Saudi Arabia": "SA",
        "Sweden": "SE",
        "Singapore": "SG",
        "Slovenia": "SI",
        "Slovakia": "SK",
        "Thailand": "TH",
        "Turkey": "TR",
        "Taiwan": "TW",
        "Ukraine": "UA",
        "United States": "US",
        "Venezuela": "VE",
        "South Africa": "ZA"
    ]
    
    var selectedCategory: ((String?,String?) -> Void)?
    
    // Properties to track selected category and country
    var selectedCategoryName: String?
    var selectedCountryName: String?
    var selectedCategoryValueName: String?
    var selectedCountryValueName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterCell")
        setupDoneButton()
        setupTableViewInsets()
    }
    
    // MARK: - UI Setup
    private func setupDoneButton() {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = UIColor(red: 0.33, green: 0.76, blue: 0.71, alpha: 1.00)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.textAlignment = .center
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
        
        let filterListWidth = UIScreen.main.bounds.width - 70
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 44),
            doneButton.widthAnchor.constraint(equalToConstant: filterListWidth)
        ])
    }
    
    private func setupTableViewInsets() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
    }
    
    // MARK: - Button Actions
    
    @objc private func doneButtonTapped() {
        selectedCategory?(selectedCategoryValueName,selectedCountryValueName)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .categories:
            return categories.keys.count
        case .countries:
            return countries.keys.count
        case .none:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)

        switch Section(rawValue: indexPath.section) {
        case .categories:
            let categoryNames = Array(categories.keys)
            let categoryName = categoryNames[indexPath.row]
            cell.textLabel?.text = categoryName
         
            if let selectedCategoryValue = categories[categoryName], selectedCategoryValue == selectedCategoryValueName {
                // If the current category's value matches the selectedCategoryValueName, set the checkmark accessory type
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        case .countries:
            let countryNames = Array(countries.keys)
            let countryName = countryNames[indexPath.row]
            cell.textLabel?.text = countryName

            if let selectedCountryValue = countries[countryName], selectedCountryValue == selectedCountryValueName {
                // If the current country's value matches the selectedCountryValueName, set the checkmark accessory type
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        case .none:
            break
        }

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch Section(rawValue: indexPath.section) {
        case .categories:
            let categoryNames = Array(categories.keys)
            let categoryName = categoryNames[indexPath.row]
            let selectedCategoryValue = categories[categoryName] // Store the selected category value
            
            selectedCategoryName = categoryName
            selectedCategoryValueName = selectedCategoryValue // Store the selected category value
            
        case .countries:
            let countryNames = Array(countries.keys)
            let countryName = countryNames[indexPath.row]
            let selectedCountryValue = countries[countryName] // Store the selected country value
            
            selectedCountryName = countryName
            selectedCountryValueName = selectedCountryValue // Store the selected country value
            
            
        case .none:
            break
        }
        
        // Reload the table view to update checkmarks
        tableView.reloadData()
    }

}

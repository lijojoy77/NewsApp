//
//  VCHome.swift
//  NewsApp
//
//  Created by Lijo Joy on 13/09/2023.
//

import UIKit

class VCHome: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCustomNavigationBar(title: "All news", leftButtonImageName: "", leftButtonSelector: #selector(goBack(_:)), rightButtonTitle: "", rightButtonSelector: #selector(selectCategory(_:)))
    }

    @objc func goBack(_ sender: Any){
   
    }
   
    @objc func selectCategory(_ sender: Any){
   
    }
}

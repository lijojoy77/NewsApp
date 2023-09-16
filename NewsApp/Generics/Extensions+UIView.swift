//
//  Extensions+UIView.swift
//  NewsApp
//
//  Created by Lijo Joy on 13/09/2023.
//

import Foundation
import UIKit


extension UIViewController {
    func setupCustomNavigationBar(title: String, leftButtonImageName: String?, leftButtonSelector: Selector?, rightButtonImageName: String?, rightButtonSelector: Selector?) {
        guard let navigationController = navigationController else {
            return
        }
        
        // Customize navigation bar appearance
        navigationController.navigationBar.barTintColor = UIColor(red: 0.33, green: 0.76, blue: 0.71, alpha: 1.00) //#53C3B4
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.titleTextAttributes = [
                    .font: UIFont(name: "AvenirNext-DemiBold", size: 21.0)!,
                    .foregroundColor: UIColor.white 
                ]

        if let leftImage = leftButtonImageName, !leftImage.isEmpty, let selector = leftButtonSelector {
            navigationItem.leftBarButtonItem = createBarButton(imageName: leftImage, selector: selector)
        }

        if let rightImage = rightButtonImageName, !rightImage.isEmpty, let selector = rightButtonSelector {
            navigationItem.rightBarButtonItem = createBarButton(imageName: rightImage, selector: selector)
        }
            
        // Right Button
        //navigationItem.rightBarButtonItem = createBarButton(title: rightButtonTitle, font: UIFont(name: "AvenirNext-Medium", size: 18)!, selector: rightButtonSelector)

        // Set the title
        navigationItem.title = title
        navigationController.hidesBarsOnSwipe = false
        UINavigationBar.appearance().barStyle = .default // or .black
        UINavigationBar.appearance().isTranslucent = false

    }

    private func createBarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)

        let barButton = UIBarButtonItem(customView: button)
        barButton.tintColor = .black

        return barButton
    }

    private func createBarButton(title: String, font: UIFont, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: selector, for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }
}

//
//  ViewController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 3/14/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class MainController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = Theme.secondaryBackgroundColor
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)]
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.backgroundColor]
            let standardButtonAppearance = UIBarButtonItemAppearance(style: .plain)
            let doneButtonAppearance = UIBarButtonItemAppearance(style: .done)
            standardButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)]
            doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)]
            navigationBarAppearance.buttonAppearance = standardButtonAppearance
            navigationBarAppearance.doneButtonAppearance = doneButtonAppearance
            navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationBar.standardAppearance = navigationBarAppearance
            navigationBar.compactAppearance = navigationBarAppearance

        } else {
            // Fallback on earlier versions
            navigationBar.barTintColor = Theme.secondaryBackgroundColor
            navigationBar.titleTextAttributes = [.foregroundColor: Theme.backgroundColor]
        }
        view.backgroundColor = Theme.primaryBackgroundColor
        
        //let sessionViewController = SessionViewController()
        let transitionController = TransitionController()
        viewControllers = [transitionController]
    }

    func showAuthAlert(message: String, title: String, isAuthError: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            if isAuthError {
                self.logoutUser()
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func logoutUser() {
        //handle logout
    }
}


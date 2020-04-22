//
//  LoginController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 3/15/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import Foundation
import UIKit

//sends back the data to the main controller to handle login
protocol LoginDelegate {
    //login functions go here
}

class LoginViewController: BaseViewController {
    
//    var delegate: LoginDelegate?
    
    let usernameTextField: FormTextField = FormTextField(label: "Username", placeholder: "", options: nil)
    let passwordTextField: FormTextField = {
        let ftf = FormTextField(label: "Password", placeholder: "", options: nil)
        ftf.getTextField().isSecureTextEntry = true
        return ftf
    }()
    
    let logo:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "orbit_logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        let buttonTitle = NSAttributedString(string: "LOGIN", attributes: [NSAttributedString.Key.font: Theme.textFieldFont, NSAttributedString.Key.foregroundColor: UIColor.white])
        button.backgroundColor = Theme.buttonColor
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = Theme.secondaryBackgroundColor
        self.view.addSubview(logo)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginBtn)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(15)
            make.centerX.equalToSuperview().offset(-8)
            make.width.equalTo(300)
            make.height.equalTo(55)
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview().offset(-8)
            make.width.equalTo(300)
            make.height.equalTo(55)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(300)
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func loginUser() {
        let nc = self.navigationController as! MainController
        guard let usernameText = usernameTextField.getTextField().text,
            let passwordText = passwordTextField.getTextField().text else {
                nc.showAuthAlert(message: "Username and password fields must not be empty", title: "Invalid Input", isAuthError: false)
                return
        }
        if usernameText.count == 0 || passwordText.count == 0 {
            nc.showAuthAlert(message: "Username and password fields must not be empty", title: "Invalid Input", isAuthError: false)
            return
        }
        nc.login()
    }
}

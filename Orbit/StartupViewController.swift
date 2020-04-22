//
//  StartupViewController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/22/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {
    let logo:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "orbit_logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        let buttonTitle = NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: Theme.textFieldFont, NSAttributedString.Key.foregroundColor: UIColor.white])
        button.backgroundColor = Theme.buttonColor
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    lazy var signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(signin), for: .touchUpInside)
        let buttonTitle = NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: Theme.textFieldFont, NSAttributedString.Key.foregroundColor: UIColor.white])
        button.backgroundColor = Theme.buttonColor
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginBtn)
        view.addSubview(signUpBtn)
        view.addSubview(logo)
        
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(300)
        }
        signUpBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(loginBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(300)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func login() {
        let loginViewController = LoginViewController()
        show(loginViewController, sender: self)
    }
    
    @objc func signin() {
        let signUpView = RegisterViewController()
        show(signUpView, sender: self)
    }

}

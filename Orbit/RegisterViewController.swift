//
//  RegisterViewController.swift
//  Orbit
//
//  Created by Maryam Bokhari  on 4/18/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

    lazy var userNameTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        return paddedTextField
    }()
    lazy var passwordTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        paddedTextField.isSecureTextEntry =  true
        return paddedTextField
    }()
    lazy var confirmedPasswordTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        paddedTextField.isSecureTextEntry =  true
        return paddedTextField
    }()
    
    lazy var signUpButton: UIButton = {
        let paddedButton = UIButton(type: .system)
        paddedButton.backgroundColor = .blue
        paddedButton.layer.cornerRadius = 15
        paddedButton.tintColor = .white
        paddedButton.setTitle("Sign Up", for: .normal)
        paddedButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return paddedButton
        
    }()
    let logo:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "orbit_logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    fileprivate func setUpRegisterBox() {

        let userNameView: UIView = addTextFieldLabel(labelText: "Username", textField: userNameTextField, labelWidth: 90 )
        let passwordView: UIView = addTextFieldLabel(labelText: "Password", textField: passwordTextField, labelWidth: 90 )
        let confirmedPasswordView: UIView = addTextFieldLabel(labelText: "Confirm Password", textField: confirmedPasswordTextField, labelWidth: 160)
        view.addSubview(userNameView)
        view.addSubview(passwordView)
        view.addSubview(confirmedPasswordView)
        view.addSubview(signUpButton)
        view.addSubview(logo)
        
        userNameView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-200)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(30)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(userNameView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(30)
        }

        confirmedPasswordView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(30)
        }

        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmedPasswordView.snp.bottom).offset(20)
            make.right.equalTo(confirmedPasswordView.snp.right)
            make.height.equalTo(35)
            make.width.equalTo(100)

        }
        logo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.secondaryBackgroundColor
        setUpRegisterBox()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.isHidden = false
    }
    func addTextFieldLabel(labelText:String , textField:PaddedTextField, labelWidth:Int = 120)-> UIView{
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        view.addSubview(label)
        view.addSubview(textField)

        label.text = labelText + ":"
        label.font = UIFont.init(name: Theme.font, size: 18)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(labelWidth)
            make.height.equalTo(label.font.lineHeight)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.bottom.height.equalToSuperview()
            make.left.width.equalToSuperview().offset(labelWidth)
        }
        
        view.layer.cornerRadius = 25
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        return view
    }
    

    @objc func signUpButtonTapped() {
        let nc = navigationController as? MainController
        nc?.login()
    }

}


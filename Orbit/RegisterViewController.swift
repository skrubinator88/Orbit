//
//  RegisterViewController.swift
//  Orbit
//
//  Created by Maryam Bokhari  on 4/18/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    let userNameTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        return paddedTextField
    }()
    let passwordTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        return paddedTextField
    }()
    let confirmedPasswordTextField: PaddedTextField = {
        let paddedTextField = PaddedTextField()
        return paddedTextField
    }()
    
    let signUpButton: UIButton = {
        let paddedButton = UIButton()
        paddedButton.backgroundColor = .blue
        return paddedButton
        
    }()
    let logo:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "orbit_logo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let registerBox:UIView = {
        let rBox=UIView()
        rBox.backgroundColor = UIColor.gray
        rBox.frame = CGRect(x: 100, y: 100, width: 200, height: 400)
        return rBox
    }()

    fileprivate func setUpRegisterBox() {

        let userNameView: UIView = addTextFieldLabel(labelText: "Username", textField: userNameTextField, labelWidth: 90 )
        let passwordView: UIView = addTextFieldLabel(labelText: "Password", textField: passwordTextField, labelWidth: 90 )
        let confirmedPasswordView: UIView = addTextFieldLabel(labelText: "Confirm Password", textField: confirmedPasswordTextField, labelWidth: 160)
        registerBox.addSubview(userNameView)
        registerBox.addSubview(passwordView)
        registerBox.addSubview(confirmedPasswordView)
        registerBox.addSubview(signUpButton)
        view.addSubview(logo)
        registerBox.layer.cornerRadius = 8.0
        registerBox.clipsToBounds = true
        registerBox.layer.borderWidth = 2
        registerBox.layer.borderColor = UIColor.blue.cgColor
        registerBox.backgroundColor = UIColor.white
        view.addSubview(registerBox)
        
        userNameView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.right.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(userNameView.snp.bottom).offset(15)
            make.right.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }

        confirmedPasswordView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(15)
            make.right.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }

        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmedPasswordView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(50)

        }
        registerBox.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(400)
            
        }
        logo.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.view)
            make.right.equalTo(self.view).offset(100)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = Theme.secondaryBackgroundColor
        setUpRegisterBox()
        // Do any additional setup after loading the view.
        
    }
    func addTextFieldLabel(labelText:String , textField:PaddedTextField, labelWidth:Int = 120)-> UIView{
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        view.addSubview(textField)

        label.text = labelText
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(3)
            make.centerY.equalToSuperview()
            make.width.equalTo(labelWidth)
            make.height.equalTo(label.font.lineHeight)
        }
        
        textField.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-3)
            make.top.bottom.height.equalToSuperview()
            make.left.width.equalToSuperview().offset(labelWidth)
        }
        
        return view
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


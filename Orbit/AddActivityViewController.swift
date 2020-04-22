//
//  AddActivityViewController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Activity Name"
        label.font = UIFont.init(name: Theme.font, size: 23)
        return label
    }()
    let activityTextField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.font = UIFont.init(name: Theme.font, size: 20)
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        return tf
    }()
    
    let sessionLabel: UILabel = {
        let label = UILabel()
        label.text = "Session Interval (min)"
        label.font = UIFont.init(name: Theme.font, size: 23)
        return label
    }()
    let sessionTextField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.font = UIFont.init(name: Theme.font, size: 20)
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        return tf
    }()
    
    let breakLabel: UILabel = {
        let label = UILabel()
        label.text = "Break Interval (min)"
        label.font = UIFont.init(name: Theme.font, size: 23)
        return label
    }()
    let breakTextField: PaddedTextField = {
        let tf = PaddedTextField()
        tf.font = UIFont.init(name: Theme.font, size: 20)
        tf.layer.cornerRadius = 15
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        return tf
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE", for: .normal)
        button.backgroundColor = Theme.secondaryBackgroundColor
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityLabel)
        view.addSubview(activityTextField)

        view.addSubview(sessionLabel)
        view.addSubview(sessionTextField)

        view.addSubview(breakLabel)
        view.addSubview(breakTextField)
        
        view.addSubview(saveButton)
        
        activityLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(150)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(200)
        }
        activityTextField.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(200)
            make.left.equalTo(activityLabel.snp.right).offset(20)
            make.top.equalTo(activityLabel.snp.top)
        }
        
        sessionLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(220)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(activityLabel.snp.bottom).offset(50)
        }
        sessionTextField.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(45)
            make.left.equalTo(sessionLabel.snp.right).offset(20)
            make.top.equalTo(sessionLabel.snp.top)
        }
        
        breakLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(220)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(sessionLabel.snp.bottom).offset(30)
        }
        breakTextField.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(45)
            make.left.equalTo(breakLabel.snp.right).offset(20)
            make.top.equalTo(breakLabel.snp.top)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(breakTextField.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func saveButtonTapped() {
        var activityInterval = Int(sessionTextField.text!)
        var breakInterval = Int(breakTextField.text!)
        
        activityInterval = activityInterval! * 60
        breakInterval = breakInterval! * 60
        let session = Session(cycles: 0, activityLength: activityInterval!, breakLength: breakInterval!, activityName: activityTextField.text!)
        
        let sessionViewController = SessionViewController()
        sessionViewController.session = session
        Session.saveSession(session: session)
        navigationController?.popViewController(animated: true)
        navigationController?.show(sessionViewController, sender: self)
    }
}

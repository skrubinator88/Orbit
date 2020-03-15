//
//  FormTextField.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 3/15/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FormTextField: UIView, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var options: [String]? {
        didSet {
            self.getTextField().inputView = pickerView
        }
    }
    
    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }()
    
    convenience init(label: String, placeholder: String, options: [String]?) {
        self.init()
        let textLabel = UILabel()
        textLabel.text = label
        textLabel.font = Theme.textFieldHeaderFont
        let tf = PaddedTextField()
        tf.placeholder = placeholder
        tf.delegate = self
        tf.font = Theme.textFieldFont
        tf.layer.borderWidth = 0.7
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.layer.cornerRadius = 5
        tf.backgroundColor = .white
        self.addSubview(textLabel)
        self.addSubview(tf)
        textLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(5)
            make.left.equalTo(self.snp.left).offset(8)
            make.height.equalTo(15)
        }
        tf.snp.makeConstraints { (make) in
            make.top.equalTo(textLabel.snp.bottom).offset(3)
            make.left.equalTo(textLabel.snp.left)
            make.right.equalTo(self.snp.right).offset(8)
            make.height.equalTo(40)
            make.width.equalTo(self.snp.width)
        }
        
        guard let options = options else { return }
        self.options = options
        if let mainOptions = self.options {
            if mainOptions.count != 0 {
                tf.inputView = pickerView
            }
        }
    }
    
    func getTextField() -> UITextField {
        return self.subviews[1] as! UITextField
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.count == 0 {
            self.pickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(pickerView, didSelectRow: 0, inComponent: 0)
        }
    }
    
}

extension FormTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let options = self.options else { return 0 }
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let options = self.options else { return "" }
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let options = self.options else { return }
        self.getTextField().text = options[row]
    }
}


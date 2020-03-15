//
//  PaddedTextField.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 3/15/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit


class PaddedTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

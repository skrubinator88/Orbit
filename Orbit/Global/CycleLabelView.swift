//
//  CycleLabelView.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

import UIKit

class CycleLabelView: UIView {

    var cycle: Int = 0 {
        didSet {
            cycleLabel.text = "\(cycle)"
        }
    }
    let cycleLabel: UILabel = {
        let label = UILabel()
        label.text = "9.0"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 30, height: 30)) {
        super.init(frame: frame)
        addSubview(cycleLabel)
        cycleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        backgroundColor = Theme.backgroundColor
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//
//  SessionTableViewCell.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    var session: Session? {
        didSet{
            activityLabel.text = session?.activityName
            cycleLabel.cycle = session?.cycles ?? 0
        }
    }
    
    var activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Activity"
        label.font = UIFont.init(name: Theme.font, size: 20)
        return label
    }()
    
    let cycleLabel = CycleLabelView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(activityLabel)
        contentView.addSubview(cycleLabel)
        
        activityLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(250)
        }
        cycleLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

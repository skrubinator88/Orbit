//
//  TransitionController.swift
//  Orbit
//
//  Created by Maryam Bokhari  on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//
import UIKit

class TransitionController: BaseViewController {
    

    var circleLayer: CAShapeLayer!
    let myCheckBox = BEMCheckBox(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    
    let circularLabel = UILabel()

    lazy var getStartedBtn: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitle = NSAttributedString(string: "show me how this works", attributes: [NSAttributedString.Key.font: Theme.aquaColor, NSAttributedString.Key.foregroundColor: Theme.darkBlue])
        button.backgroundColor = Theme.darkBlue
        button.setAttributedTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.myCheckBox.frame = CGRect(x: 0, y: 0, width: 50, height: 50);
        //self.myCheckBox.on = true;
        //self.view.addSubview(myCheckBox);
        self.view.backgroundColor = Theme.secondaryBackgroundColor
        self.view.addSubview(circularLabel)
        self.view.addSubview(getStartedBtn)
        // Do any additional setup after loading the view.
        circularLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        getStartedBtn.snp.makeConstraints { (make) in
            make.top.equalTo(circularLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(300)
        }
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


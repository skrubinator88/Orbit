//
//  PlayButton.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class PlayButton: UIButton {
    let playImage:UIImageView = {
        var m = UIImageView()
        m.image =  UIImage(named: "play")
        m.contentMode = .scaleAspectFit
        m.clipsToBounds = true
           return m
    }()
   
   lazy var playButton:UIButton = {
       var u = UIButton()
       u.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
       return u
   }()
   
   var isPressed:Bool = false{
       didSet{
           if isPressed{
               playImage.image =  UIImage(named: "pause")
           } else{
               playImage.image =  UIImage(named: "play")
           }
       }
   }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       self.addSubview(playImage)
       self.addSubview(playButton)
       
       playImage.snp.makeConstraints { (make) in
           make.left.right.top.bottom.equalTo(0)
       }
       
       playButton.snp.makeConstraints { (make) in
           make.left.right.top.bottom.equalTo(0)
       }
   }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
   @objc private func playButtonAction(){
       isPressed = !isPressed
   }
    
    

}

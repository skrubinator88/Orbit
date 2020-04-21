//
//  SessionViewController.swift
//  Orbit
//
//  Created by Oseriemen Ivbaze on 4/21/20.
//  Copyright © 2020 Georgia State University. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

    var circleLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    let opacityAnimation = CABasicAnimation(keyPath: "opacity")

    func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }

    func animateCircle(duration: TimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        // Set the animation duration appropriately
        animation.duration = duration

        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1

        // Do a linear animation (i.e The speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // Right value when the animation ends
        circleLayer.strokeEnd = 1.0

        // Do the actual animation
        circleLayer.add(animation, forKey: "animateCircle")
    }
    
    let timerLabel = UILabel()
    let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "Activity"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    lazy var playButton:UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "play"), for: .normal)
        return button
    }()
    
    var isPressed:Bool = false{
        didSet{
            if isPressed{
                playButton.setImage(UIImage(named: "pause"), for: .normal)
            } else{
                playButton.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }
    
    var pulse:PulseAnimation!
    
    var seconds = 60
    var sessionTotalSeconds = 60
    
    var timer = Timer()
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //track layer
        let circlePath = UIBezierPath(arcCenter: .zero, radius: 175, startAngle: CGFloat(0 - (Double.pi / 2) + 0.00001), endAngle: CGFloat(0 - (Double.pi / 2)), clockwise: true)

        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.lineCap = .round
        pulsatingLayer.path = circlePath.cgPath
        pulsatingLayer.fillColor = UIColor(red: 255/255, green: 29/255, blue: 0/255, alpha: 0.3).cgColor
        pulsatingLayer.lineWidth = 15.0;
        pulsatingLayer.position = view.center
        pulsatingLayer.opacity = 0
        view.layer.addSublayer(pulsatingLayer)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let trackLayer = CAShapeLayer()
        trackLayer.lineCap = .round
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.strokeColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 0.5).cgColor
        trackLayer.position = view.center
        trackLayer.lineWidth = 20.0;
        view.layer.addSublayer(trackLayer)
         animatePulsatingLayer()
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.

        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.lineCap = .round
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.position = view.center
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 20.0;

        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0

        // Add the circleLayer to the view's layer's sublayers
        view.layer.addSublayer(circleLayer)

        
        view.addSubview(activityLabel)
        view.addSubview(timerLabel)
        view.addSubview(playButton)

        activityLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        timerLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }
        playButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(45)
            make.top.equalTo(timerLabel.snp.bottom).offset(15)
            make.centerX.equalTo(timerLabel.snp.centerX)
        }
        
        timerLabel.font = UIFont.systemFont(ofSize: 80)
        timerLabel.textAlignment = .center
        timerLabel.text = timeString(time: TimeInterval(seconds))

    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        if running && seconds == sessionTotalSeconds{
            animateCircle(duration: TimeInterval(seconds))
        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
            running = false
        } else {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @objc func startButtonTapped() {
        running = true
        if isPressed {
            timer.invalidate()
            circleLayer.pause()
            self.togglePulsatingLayer(toggle: false)
        } else {
            runTimer()
            circleLayer.resume()
            self.togglePulsatingLayer(toggle: true)
        }
        isPressed = !isPressed
    }
    
    func togglePulsatingLayer(toggle:Bool) {
        if toggle {
            opacityAnimation.toValue = 1
            opacityAnimation.duration = 1
            opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            pulsatingLayer.add(opacityAnimation, forKey: "fade")
            pulsatingLayer.opacity = 1
        } else {
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.toValue = 0
            animation.duration = 1
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            pulsatingLayer.add(animation, forKey: "fadeOut")
            pulsatingLayer.opacity = 0
        }
    }
    
    @objc func resetButtonTapped() {
        timer.invalidate()
        seconds = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isPressed = false
    }
    
}

extension SessionViewController {
}

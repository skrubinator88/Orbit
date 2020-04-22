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

    var session: Session! {
        didSet {
            activityLabel.text = session.activityName
            sessionTotalSeconds = session.activityLength
            breakTotalSeconds = session.breakLength
        }
    }
    
    var circleLayer: CAShapeLayer!
    var pulsatingLayer: CAShapeLayer!
    let opacityAnimation = CABasicAnimation(keyPath: "opacity")
    
    var isBreak = false {
        didSet {
            if isBreak {
                seconds = breakTotalSeconds
                timerLabel.text = timeString(time: TimeInterval(breakTotalSeconds))
                activityLabel.text = "Break"
                activityLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)
                playButton.tintColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)
                timerLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)
                view.backgroundColor = .white
                circleLayer.strokeColor = UIColor(red: 37/255, green: 206/255, blue: 0/255, alpha: 1.0).cgColor
                circleLayer.fillColor = UIColor.white.cgColor
                pulsatingLayer.fillColor = UIColor(red: 132/255, green: 214/255, blue: 0/255, alpha: 0.5).cgColor
                running = true
                runTimer()
                
            } else {
                seconds = sessionTotalSeconds
                timerLabel.text = timeString(time: TimeInterval(sessionTotalSeconds))
                activityLabel.text = session.activityName
                activityLabel.textColor = .white
                playButton.tintColor = .white
                timerLabel.textColor = .white
                view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)
                circleLayer.strokeColor = Theme.secondaryBackgroundColor.cgColor
                circleLayer.fillColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1).cgColor
                pulsatingLayer.fillColor = Theme.secondaryBackgroundColor.withAlphaComponent(0.5).cgColor
                running = true
                runTimer()
            }
        }
    }
    
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
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    lazy var playButton:UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "play"), for: .normal)
        button.tintColor = .white
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
    var sessionTotalSeconds = 300
    var breakTotalSeconds = 300
    
    var timer = Timer()
    var running = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1)
        //track layer
        let circlePath = UIBezierPath(arcCenter: .zero, radius: 160, startAngle: CGFloat(0 - (Double.pi / 2) + 0.00001), endAngle: CGFloat(0 - (Double.pi / 2)), clockwise: true)

        pulsatingLayer = CAShapeLayer()
        pulsatingLayer.lineCap = .round
        pulsatingLayer.path = circlePath.cgPath
        pulsatingLayer.fillColor = Theme.secondaryBackgroundColor.withAlphaComponent(0.5).cgColor
        pulsatingLayer.lineWidth = 15.0;
        pulsatingLayer.position = view.center
        pulsatingLayer.opacity = 0
        view.layer.addSublayer(pulsatingLayer)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        let trackLayer = CAShapeLayer()
        trackLayer.lineCap = .round
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.strokeColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 0.2).cgColor
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
        circleLayer.fillColor = UIColor(red: 51/255, green: 51/255, blue: 102/255, alpha: 1).cgColor
        circleLayer.position = view.center
        circleLayer.strokeColor = Theme.secondaryBackgroundColor.cgColor
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
        timerLabel.textColor = .white
        seconds = sessionTotalSeconds
        timerLabel.text = timeString(time: TimeInterval(sessionTotalSeconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        if !isBreak {
            if running && seconds == sessionTotalSeconds{
                animateCircle(duration: TimeInterval(sessionTotalSeconds))
            }
        } else {
            if running && seconds == breakTotalSeconds{
                animateCircle(duration: TimeInterval(breakTotalSeconds))
            }
        }

    }
    
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
            running = false
            if !isBreak {
                isBreak = true
            } else {
                isBreak = !isBreak
            }
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
        timerLabel.text = timeString(time: TimeInterval(sessionTotalSeconds))
        isPressed = false
    }
    
}

extension SessionViewController {
}

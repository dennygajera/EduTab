//
//  ProgressCircularView.swift
//  Paperless housie
//
//  Created by Darshan on 08/05/20.
//  Copyright © 2020 Darshan. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
    // First create two layer properties
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    var startingPoint = Double()
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    func createCircularPath() {
        print(Double.pi)
        if hasTopNotch {
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 25, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
            
             circleLayer.path = circularPath.cgPath
            circleLayer.path = circularPath.cgPath
            progressLayer.path = circularPath.cgPath
        } else  {
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 18, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
             circleLayer.path = circularPath.cgPath
            circleLayer.path = circularPath.cgPath
            progressLayer.path = circularPath.cgPath
        }
       
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 2.0
        circleLayer.strokeColor = UIColor.white.cgColor
        
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 2.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.AppColor().cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .removed
        circularProgressAnimation.isRemovedOnCompletion = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

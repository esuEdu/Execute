//
//  ProgressCircleBarComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

class CircularProgressView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    var radius: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath(radius: radius ?? 63.5)
//        createCircularPath(radius: radius ?? 51)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath(radius: radius ?? 63.5)
//        createCircularPath(radius: radius ?? 51)
    }
    
    func createCircularPath(radius: CGFloat) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 190, y: 850 / 2.0), radius: radius, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .square
        circleLayer.lineWidth = 0.20 * radius
        circleLayer.strokeColor = UIColor.systemGray2.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .square
        progressLayer.lineWidth = 0.20 * radius
        progressLayer.strokeEnd = 0.3
        progressLayer.strokeColor = UIColor.purple.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    

}

#Preview{
    CircularProgressView()
}

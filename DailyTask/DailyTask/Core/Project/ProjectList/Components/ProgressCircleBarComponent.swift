//
//  ProgressCircleBarComponent.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

class CircularProgressView: UIView {
    private var progressLayer: CAShapeLayer!
    private var bgProgressLayer: CAShapeLayer!
    private var progress: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCircularProgressLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCircularProgressLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCircularProgressLayer()
    }
    
    private func setupCircularProgressLayer() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: (frame.size.width - 20) / 2,
            startAngle: -CGFloat.pi / 2,
            endAngle: 3 * CGFloat.pi / 2,
            clockwise: true
        )
        
        bgProgressLayer = CAShapeLayer()
        bgProgressLayer.path = circularPath.cgPath
        bgProgressLayer.strokeColor = UIColor.systemGray4.cgColor
        bgProgressLayer.lineWidth = 10
        bgProgressLayer.fillColor = UIColor.clear.cgColor
        bgProgressLayer.lineCap = .square
        bgProgressLayer.strokeEnd = progress
        layer.addSublayer(bgProgressLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.lineWidth = 5
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .square
        progressLayer.strokeEnd = progress
        layer.addSublayer(progressLayer)
        
    }
    
    func setProgress(_ value: CGFloat) {
        progress = max(0.0, min(1.0, value))
        bgProgressLayer.strokeEnd = 1
        progressLayer.strokeEnd = progress
    }
    
    private func updateCircularProgressLayer() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: (frame.size.width - 10) / 2,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )
        
        progressLayer.path = circularPath.cgPath
        bgProgressLayer.path = circularPath.cgPath
    }
}


class CircularProgressView2: UIView {
    
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

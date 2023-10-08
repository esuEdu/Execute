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
    private var lineWidth: CGFloat?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCircularProgressLayer()
    }
    
    init(lineWidth: CGFloat = 5) {
        self.lineWidth = lineWidth
        super.init(frame: .zero)
        
        setupCircularProgressLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCircularProgressLayer()
    }
    
    private func setupCircularProgressLayer() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: (frame.size.width - 10) / 2,
            startAngle: -CGFloat.pi / 2,
            endAngle: 3 * CGFloat.pi / 2,
            clockwise: true
        )
        
        bgProgressLayer = CAShapeLayer()
        bgProgressLayer.path = circularPath.cgPath
        bgProgressLayer.strokeColor = UIColor.systemGray4.cgColor
        bgProgressLayer.lineWidth = lineWidth!
        bgProgressLayer.fillColor = UIColor.clear.cgColor
        bgProgressLayer.lineCap = .square
        bgProgressLayer.strokeEnd = progress
        layer.addSublayer(bgProgressLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.lineWidth = lineWidth!
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
            radius: (frame.size.width - lineWidth!) / 2,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )
        
        progressLayer.path = circularPath.cgPath
        bgProgressLayer.path = circularPath.cgPath
    }
}



#Preview{
    CircularProgressView()
}

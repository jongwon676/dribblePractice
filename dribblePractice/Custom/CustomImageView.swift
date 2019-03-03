import UIKit
import Foundation

class CustomImageView: UIImageView {
    // contents를 담당하는 layer가 필요함
    let imageLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    
    let lineWidth: CGFloat = 6.0
    
    var img: UIImage?{
        didSet{
            imageLayer.contents = img?.cgImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(imageLayer)
        
        circleLayer.path = UIBezierPath.init(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        circleLayer.shadowOffset = CGSize(width: 1, height: 1)
        circleLayer.shadowRadius = 2
        circleLayer.shadowOpacity = 0.2
        
        
        circleLayer.frame = bounds
        maskLayer.path = circleLayer.path
        imageLayer.mask = maskLayer
        imageLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
        imageLayer.frame = bounds
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

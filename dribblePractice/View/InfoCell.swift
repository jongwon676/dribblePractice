import UIKit

class InfoCell: UICollectionViewCell{
    
    let frontView = InfoFrontView()
    let backView = InfoBackView()
    
    let animDuration: Double = 0.4
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 2, height: 2)
        
        addSubview(backView)
        addSubview(frontView)
        
        backView.fillSuperview()
        frontView.fillSuperview()
        
        frontView.actionFlip = { [weak self] in
            guard let `self` = self else { return  }
            
            UIView.transition(with: self, duration: self.animDuration, options: .transitionFlipFromBottom, animations: {
                self.insertSubview(self.backView, aboveSubview: self.frontView)
                self.frontView.alpha = 0
                self.backView.alpha = 1
            }, completion: nil)
        }
        
        backView.actionFlip = { [weak self] in
            guard let `self` = self else { return  }
            UIView.transition(with: self, duration: self.animDuration, options: .transitionFlipFromTop, animations: {
                self.insertSubview(self.frontView, aboveSubview: self.backView)
                self.backView.alpha = 0
                self.frontView.alpha = 1
            }, completion: nil)
        }   
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}

import UIKit

class InfoCell: UICollectionViewCell{
    
    let frontView = InfoFrontView()
    let backView = InfoBackView()
    let animDuration: Double = 0.4
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
        backgroundColor = .white
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
            }, completion: nil)
        }
        
        backView.actionFlip = { [weak self] in
            guard let `self` = self else { return  }
            UIView.transition(with: self, duration: self.animDuration, options: .transitionFlipFromTop, animations: {
                self.insertSubview(self.frontView, aboveSubview: self.backView)
            }, completion: nil)
        }
        
        
        
    }
    func flipFrontToBack(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
}

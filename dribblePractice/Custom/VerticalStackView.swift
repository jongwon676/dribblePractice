import UIKit
class VerticalStackView: UIStackView{
    convenience init(arrangedSubViews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution? = nil) {
        
        self.init(frame: .zero)
        self.axis = .vertical
        self.spacing = spacing
        arrangedSubViews.forEach { (view) in
            self.addArrangedSubview(view)
        }
        if let distribution = distribution{
            self.distribution = distribution
        }
    }
}

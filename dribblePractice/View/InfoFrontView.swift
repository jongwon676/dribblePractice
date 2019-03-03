import UIKit
class InfoFrontView: UIView{
    
    let titleLabel = UILabel(text: "너에게로 떠나는 여행", font: UIFont.systemFont(ofSize: 16, weight: .semibold), numberOfLines: 1)
    let authorLabel = UILabel(text: "버즈", font: UIFont.systemFont(ofSize: 12), textColor: #colorLiteral(red: 0.2522263601, green: 0.2522263601, blue: 0.2522263601, alpha: 1))
    let timeLabel = UILabel(text: "03:29", font: UIFont.systemFont(ofSize: 12), textColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    let imageView = CustomImageView(frame: .zero)
    

    let menuButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "icons8-menu-vertical-filled-50").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.constrainWidth(constant: 20)
        btn.addTarget(self, action: #selector(handleFlip), for: .touchUpInside)
        return btn
    }()
    
    var actionFlip: (()->())?
    
    
    @objc func handleFlip(){
        actionFlip?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        imageView.constrainWidth(constant: 70)
        imageView.constrainHeight(constant: 70)
        imageView.img = #imageLiteral(resourceName: "xIbScaX")
        
        let overallStackView = HorizontolStackView(arrangedSubViews:
            [imageView,
             VerticalStackView(arrangedSubViews: [titleLabel,authorLabel,timeLabel], spacing: 5, distribution: .fill),
             menuButton
            ]
            , spacing: 30 )
        
        overallStackView.alignment = .center
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

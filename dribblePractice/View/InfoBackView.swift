import UIKit

class InfoBackView: UIView{
    
    func getIconButton(image: UIImage) -> UIButton{
        let btn = UIButton(type: .system)
        btn.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }
    
    lazy var trashButton = getIconButton(image: #imageLiteral(resourceName: "icons8-trash-can-48"))
    lazy var folderButton = getIconButton(image: #imageLiteral(resourceName: "icons8-folder-48"))
    lazy var cancelButton = getIconButton(image: #imageLiteral(resourceName: "icons8-delete-48"))
    lazy var plusButton = getIconButton(image: #imageLiteral(resourceName: "icons8-plus-48"))
    
    
  
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
        
       let overallStacView = HorizontolStackView(arrangedSubViews: [
        trashButton,
        folderButton,
        cancelButton,
        plusButton,
        menuButton
        ], spacing: 5, distribution: .fillEqually)
        addSubview(overallStacView)
        
        overallStacView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        overallStacView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        overallStacView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

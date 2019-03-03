import UIKit
import SpriteKit

class InfoBackView: SKView{
    
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
  
    @objc func deleteCells(){
        [trashButton,folderButton, cancelButton, plusButton].forEach { (btn) in
            btn.alpha = 0
            addToScene(button: btn)
        }
        anim()
    }
    
    let buttonScene = SKScene(size: .zero)
    var nodes = [SKSpriteNode]()
    
    
    
    func anim(){
        nodes.enumerated().forEach { (idx,node) in
            let yy = max(CGFloat(Int(arc4random()) % 30),10)
            let xx:CGFloat = 50
            let duration: Double = 1.0
            let randDelay = Double(Int(arc4random()) % 10000) / Double(40000)
            let delay = SKAction.wait(forDuration: randDelay )
            let actions = [
                delay,
                SKAction.moveBy(x: xx, y: yy, duration: duration),
                
                SKAction.customAction(withDuration: duration, actionBlock: { node, duration in
                    node.removeFromParent()
                })
            ]
            node.run(SKAction.sequence(actions))
        }
    }
    
    
    var stackOffsetX: CGFloat = 0
    var stackOffsetY:CGFloat = 0
    var overallStacView: HorizontolStackView?
    
    func addToScene(button: UIButton){
        let img = button.imageView?.image
        guard let image = img else { return }
        let pixels = image.getPixels()
        
        let maxY = image.size.height
        let black = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        for y in 0..<Int(image.size.height) {
            for x in 0..<Int(image.size.width){
                var color = pixels[y * Int(image.size.width) + x]
                if color == black{
                    color = buttonScene.backgroundColor
                }
                
                let node = SKSpriteNode(color: color, size: CGSize(width: 1, height: 1))
                
                let offsetX = button.frame.origin.x
                let offsetY = button.frame.origin.y
                
                let newX = offsetX + stackOffsetX + CGFloat(x)
                let newY = ( maxY - CGFloat(y) )  + offsetY + stackOffsetY
                
                node.position = CGPoint(x: newX, y: newY)
                nodes.append(node)
                buttonScene.addChild(node)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        backgroundColor = .clear
        buttonScene.size = frame.size
        buttonScene.backgroundColor = .white
        trashButton.addTarget(self, action: #selector(deleteCells), for: .touchUpInside)
        
        buttonScene.backgroundColor = .white
        
        self.presentScene(buttonScene)
        
        
        overallStacView = HorizontolStackView(arrangedSubViews: [
        trashButton,
        folderButton,
        cancelButton,
        plusButton,
        menuButton
        ], spacing: 5, distribution: .fillEqually)
        guard let overallStacView = overallStacView else { return }
        addSubview(overallStacView)
        
        overallStacView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        overallStacView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        overallStacView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonScene.size = frame.size
        guard let stackView = overallStacView else { return }
        stackOffsetX = stackView.frame.minX + 10 // 10은 overallstackview left inset
        stackOffsetY = stackView.frame.minY
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

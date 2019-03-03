import UIKit
import SpriteKit


class InfoBackView: SKView{
    
    var removeFromCollectionView: (()->())?
    
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
        btn.setImage(#imageLiteral(resourceName: "icons8-menu-vertical-40").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.constrainWidth(constant: 20)
        btn.addTarget(self, action: #selector(handleFlip), for: .touchUpInside)
        return btn
    }()
    
    var actionFlip: (()->())?
    
    @objc func handleFlip(){
        actionFlip?()
    }
  
    @objc func deleteCells(){
        containerViewToScene()
        
        [trashButton,folderButton, cancelButton, plusButton,menuButton].forEach { (btn) in
            addToScene(button: btn)
        }
        
        buttonScene.backgroundColor = .clear
        anim()
        
        [trashButton,folderButton, cancelButton, plusButton,menuButton].forEach { (btn) in
            btn.alpha = 0
        }
    }
    
    
    
    let buttonScene = SKScene(size: .zero)
    var nodes = [SKSpriteNode]()
    
    var nodeAndActions = [(SKSpriteNode,[SKAction])]()
    
    
   
    func setAnimationProperty(node: SKSpriteNode ,y: Int, x : Int){
        let yy = CGFloat(y)
        let xx: CGFloat = 10
        let totalDuration: Double = 0.6
        
        let totlaDelay = 0.5
        let percentY = Double(y) / Double(frame.height)
        let delay = totlaDelay * (1.0 - percentY)
        let duration = totalDuration - delay + Double(arc4random() % 10) / 100.0
        
        
        let delayEvent = SKAction.wait(forDuration: delay )
        
        let moveAction = SKAction.moveBy(x: xx, y: yy, duration: duration)
        moveAction.timingMode = .easeIn
        
        let actions = [
            delayEvent,
            moveAction,
            SKAction.customAction(withDuration: duration, actionBlock: { node, duration in
                node.removeFromParent()
            })
        ]

        nodeAndActions.append((node,actions))
    }
    
    
    
    
    func anim(){
        
        nodeAndActions.forEach { (node,action) in
            node.run(SKAction.sequence(action), completion: {
                
            })
        }
        removeFromCollectionView?()
        
    }
    
    
    var stackOffsetX: CGFloat = 0
    var stackOffsetY:CGFloat = 0
    var overallStacView: HorizontolStackView?
    
    
    
    func containerViewToScene(){
        print(self.frame.width)
        print(self.frame.height)
        for y in stride(from: 0, to: Int(self.frame.height), by: 2){
            for x in stride(from: 0, to: Int(self.frame.width), by: 2){
                
                
                let color = buttonScene.backgroundColor
                
                let node = SKSpriteNode(color: color, size: CGSize(width: 2, height: 2))
                
                node.position = CGPoint(x: x, y: y)
                
                setAnimationProperty(node: node, y: Int(frame.height) - y, x: x)
                nodes.append(node)
                buttonScene.addChild(node)
            }
        }
       
    }
    
    func addToScene(button: UIButton){
        let img = button.imageView?.image
        guard let image = img else { return }
        let pixels = image.getPixels()
        
        let maxY = image.size.height
        let black = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
        
        for y in stride(from: 0, to: Int(image.size.height), by: 2){
            for x in stride(from: 0, to: Int(image.size.width), by: 2){
                let color = pixels[y * Int(image.size.width) + x]
                if color == black{
                    continue
                }
                
                let node = SKSpriteNode(color: color, size: CGSize(width: 2, height: 2))
                
                let offsetX = button.frame.origin.x
                let offsetY = button.frame.origin.y
                
                let newX = offsetX + stackOffsetX + CGFloat(x)
                let newY = ( maxY - CGFloat(y) )  + offsetY + stackOffsetY
                self.setAnimationProperty(node: node, y: Int(newY), x: Int(newX))
                node.position = CGPoint(x: newX, y: newY)
                nodes.append(node)
                buttonScene.addChild(node)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        backgroundColor = .clear
        buttonScene.backgroundColor = .white
        
        buttonScene.size = frame.size
        
        trashButton.addTarget(self, action: #selector(deleteCells), for: .touchUpInside)
        
        
        
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




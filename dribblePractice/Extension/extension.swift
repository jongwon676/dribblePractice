import UIKit
extension UILabel{
    convenience init(text: String, font: UIFont,textColor: UIColor? = nil, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        
        if textColor != nil{
            self.textColor = textColor
        }
    }
}



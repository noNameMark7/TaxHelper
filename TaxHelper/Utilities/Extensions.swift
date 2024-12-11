import UIKit

class PaddedLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }
}

extension UIView {
    func setConstraint(
        top: NSLayoutYAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leading: NSLayoutXAxisAnchor? = nil,
        leadingConstant: CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil,
        trailingConstant: CGFloat = 0,
        bottom: NSLayoutYAxisAnchor? = nil,
        bottomConstant: CGFloat = 0,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerXConstant: CGFloat = 0,
        centerY: NSLayoutYAxisAnchor? = nil,
        centerYConstant: CGFloat = 0,
        width: CGFloat? = nil,
        widthMultiplier: CGFloat = 0,
        height: CGFloat? = nil,
        heightMultiplier: CGFloat = 0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: leadingConstant).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        } else if widthMultiplier > 0 {
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: widthMultiplier).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else if heightMultiplier > 0 {
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: heightMultiplier).isActive = true
        }
    }
}

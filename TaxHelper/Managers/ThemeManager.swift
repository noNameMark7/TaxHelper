import UIKit

class ThemeManager {
    
    struct Theme {
        let backgroundColor: UIColor
        let primaryTextColor: UIColor
        let secondaryTextColor: UIColor
        let tertiaryTextColor: UIColor
        let borderColor: UIColor
        let activeFieldBorderColor: UIColor
        let inactiveFieldBorderColor: UIColor
    }
    
    static let light = Theme(
        backgroundColor: .systemBackground,
        primaryTextColor: .label,
        secondaryTextColor: .secondaryLabel,
        tertiaryTextColor: .tertiaryLabel,
        borderColor: .black,
        activeFieldBorderColor: UIColor.activeField,
        inactiveFieldBorderColor: UIColor.inactiveField
    )
    
    static let dark = Theme(
        backgroundColor: .systemBackground,
        primaryTextColor: .label,
        secondaryTextColor: .secondaryLabel,
        tertiaryTextColor: .gray,
        borderColor: .white,
        activeFieldBorderColor: UIColor.activeField,
        inactiveFieldBorderColor: UIColor.inactiveField
    )
}

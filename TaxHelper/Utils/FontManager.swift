import UIKit

class FontManager {
    
    static let shared = FontManager()
    
    private init() {}
    
    func labelFont(
        withSize: CGFloat,
        withWeight: UIFont.Weight = .regular
    ) -> UIFont {
        UIFont(
            name: "AvenirNext-Regular", size: withSize
        ) ?? UIFont.systemFont(ofSize: withSize, weight: withWeight)
    }
}

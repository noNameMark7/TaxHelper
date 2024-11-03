import UIKit

class CustomSizePresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let height = containerView.bounds.height / 2.8
        let width = containerView.bounds.width
        let x: CGFloat = 0
        let y = containerView.bounds.height - height
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    /// Use presentationTransitionWillBegin method to
    /// add animation or logic when window ready to appear or
    /// dismissalTransitionWillBegin when dismiss
}

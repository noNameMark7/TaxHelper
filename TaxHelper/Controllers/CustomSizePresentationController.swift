import UIKit

class CustomSizePresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        // Define the size to be one-third of the screen
        let height = containerView.bounds.height / 2.8
        let width = containerView.bounds.width
        let x: CGFloat = 0
        let y = containerView.bounds.height - height
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
    }
}

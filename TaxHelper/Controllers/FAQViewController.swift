import UIKit

// MARK: - FAQViewController

class FAQViewController: UIViewController {

    // MARK: - Properties
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

}


// MARK: - Initial setup

private extension FAQViewController {
    
    func initialSetup() {
        configureUI()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground

    }
    
    func configureNavigationBar() {
        title = "FAQs"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTappedDoneButton)
        )
    }
    
    @objc func didTappedDoneButton() {
        dismiss(animated: true)
    }
}

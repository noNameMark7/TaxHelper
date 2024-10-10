import UIKit

// MARK: - InfoViewController

class InfoViewController: UIViewController {

    // MARK: - Properties
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

}


// MARK: - Initial setup

private extension InfoViewController {
    
    func initialSetup() {
        configureUI()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground

    }
    
    func configureNavigationBar() {
        title = "Info"
        
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

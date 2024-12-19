import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    private var mainScreenView: MainScreenView!
    
    // MARK: - Lifecycle
    override func loadView() {
        mainScreenView = MainScreenView(frame: .zero)
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
private extension MainScreenViewController {
    
    func setupUI() {
        configureNavigationBar()
        settingDelegate()
        addDoneButtonTo(mainScreenView.netPriceTextField)
        addDoneButtonTo(mainScreenView.taxTextField)
    }
    
    func configureNavigationBar() {
        title = "Tax Helper"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTappInfoButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTappQuestionButton)
        )
    }
    
    func settingDelegate() {
        mainScreenView.netPriceTextField.delegate = self
        mainScreenView.taxTextField.delegate = self
        mainScreenView.delegate = self
    }
}

// MARK: - Actions
private extension MainScreenViewController {
    
    func addDoneButtonTo(_ textField: UITextField) {
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Create a "Done" button
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self, action: #selector(doneButtonTapped)
        )

        // Add flexible space to push "Done" button to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Add the "Done" button to the toolbar
        toolbar.setItems([flexibleSpace, doneButton], animated: false)

        // Assign the toolbar as the input accessory view of the text field
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc func didTappInfoButton() {
        presentModal(InfoViewController())
    }
    
    @objc func didTappQuestionButton() {
        presentModal(FAQViewController())
    }
    
    func presentModal(_ viewController: UIViewController) {
        let nav = UINavigationController(rootViewController: viewController)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    func updateStateOnTaxSelection(taxRate: Double, state: String) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.mainScreenView.updateTextFieldState(
                strongSelf.mainScreenView.taxTextField,
                withText: "\(taxRate)",
                borderColor: UIColor.activeField
            )
            strongSelf.mainScreenView.updateButtonState(
                strongSelf.mainScreenView.selectStateButton,
                title: "\(state)"
            )
            strongSelf.updatingComponentsAfterSelectingAState()
        }
    }
    
    func updatingComponentsAfterSelectingAState() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.mainScreenView.resetButton.isHidden = false
            strongSelf.mainScreenView.taxExplanationLabel.alpha = 1.0
            strongSelf.mainScreenView.taxExplanationLabel.isHidden = true
            // Deactivate old constraint and activate the new one
            strongSelf.mainScreenView.selectStateButtonTopToLabelConstraint.isActive = false
            strongSelf.mainScreenView.selectStateButtonTopToTextFieldConstraint.isActive = true
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn) {
                strongSelf.mainScreenView.taxExplanationLabel.alpha = 0.0
                strongSelf.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension MainScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.activeField.cgColor
        textField.placeholder = nil
        mainScreenView.resetButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.layer.borderColor = UIColor.inactiveField.cgColor
            textField.placeholder = (
                textField == mainScreenView.netPriceTextField
                ? TextValues.dollarSign.rawValue
                : TextValues.salesTaxPercent.rawValue
            )
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension MainScreenViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        CustomSizePresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

// MARK: - MainScreenViewDelegate
extension MainScreenViewController: MainScreenViewDelegate {
    
    func selectStateButtonTapped() {
        let statePickerVC = StatePickerViewController()
        let nav = UINavigationController(rootViewController: statePickerVC)
        
        statePickerVC.didSelectStateTax = { [weak self] (taxRate, state) in
            guard let strongSelf = self else { return }
            strongSelf.updateStateOnTaxSelection(taxRate: taxRate, state: state)
        }
        nav.modalPresentationStyle = .custom
        nav.transitioningDelegate = self
        present(nav, animated: true)
    }
    
    func calculateButtonTapped() {
        guard let price = Double(mainScreenView.netPriceTextField.text ?? ""),
              let taxRate = Double(mainScreenView.taxTextField.text ?? "") else { return }

        let totalTaxes = price * (taxRate / 100)
        let totalPrice = price + totalTaxes
        
        mainScreenView.updateUIState(for: .calculate(String(format: "%.2f", totalPrice)))
    }
    
    func resetButtonTapped() {
        mainScreenView.updateUIState(for: .normal)
    }
}

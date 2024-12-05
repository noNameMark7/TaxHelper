import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - UI Components
    private let grossPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gross price"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "﹩"
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1.5
        label.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        label.font = FontManager.shared.labelFont(withSize: 18)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let netPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Net price"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "﹩"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 7
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        textField.keyboardType = .decimalPad
        textField.font = FontManager.shared.labelFont(withSize: 18)
        return textField
    }()
    
    private let salesTaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sales tax"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let taxTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "﹪"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 7
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = false
        textField.font = FontManager.shared.labelFont(withSize: 18)
        return textField
    }()
    
    private let taxTextFieldExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Automatically appears in the field based on the state you select."
        label.font = FontManager.shared.labelFont(withSize: 11, withWeight: .light)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let selectStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pick a state ⠆", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        return button
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CALCULATE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        resetButton.isHidden = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance(for: traitCollection)
    }
}


// MARK: - Initial setup
private extension MainScreenViewController {
    
    func initialSetup() {
        view.addSubview(grossPriceLabel)
        view.addSubview(totalPriceValueLabel)
        view.addSubview(netPriceLabel)
        view.addSubview(priceTextField)
        view.addSubview(salesTaxLabel)
        view.addSubview(taxTextField)
        view.addSubview(taxTextFieldExplanationLabel)
        view.addSubview(selectStateButton)
        view.addSubview(calculateButton)
        view.addSubview(resetButton)
        
        addDoneButtonTo(priceTextField)
        addDoneButtonTo(taxTextField)
        
        configureUI()
        setupAction()
        settingDelegate()
        configureNavigationBar()
    }
    
    func configureUI() {
        NSLayoutConstraint.activate([
            grossPriceLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            grossPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            grossPriceLabel.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            totalPriceValueLabel.topAnchor.constraint(equalTo: grossPriceLabel.bottomAnchor),
            totalPriceValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalPriceValueLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            totalPriceValueLabel.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            netPriceLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            netPriceLabel.topAnchor.constraint(equalTo: totalPriceValueLabel.bottomAnchor, constant: 10),
            netPriceLabel.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            priceTextField.topAnchor.constraint(equalTo: netPriceLabel.bottomAnchor),
            priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            priceTextField.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            salesTaxLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            salesTaxLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 10),
            salesTaxLabel.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            taxTextField.topAnchor.constraint(equalTo: salesTaxLabel.bottomAnchor),
            taxTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taxTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            taxTextField.heightAnchor.constraint(equalToConstant: BASE_HEIGHT),
            
            taxTextFieldExplanationLabel.topAnchor.constraint(equalTo: taxTextField.bottomAnchor, constant: 4),
            taxTextFieldExplanationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taxTextFieldExplanationLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            
            selectStateButton.topAnchor.constraint(equalTo: taxTextFieldExplanationLabel.bottomAnchor, constant: 20),
            selectStateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectStateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            selectStateButton.heightAnchor.constraint(equalToConstant: HEIGHT_ANCHOR),
            
            calculateButton.topAnchor.constraint(equalTo: selectStateButton.bottomAnchor, constant: 24),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            calculateButton.heightAnchor.constraint(equalToConstant: HEIGHT_ANCHOR),
            
            resetButton.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 12),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: BASE_MULTIPLIER),
            resetButton.heightAnchor.constraint(equalToConstant: HEIGHT_ANCHOR),
        ])
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = DARK_APPEARANCE
            selectStateButton.setTitleColor(.white, for: .normal)
            selectStateButton.layer.borderColor = UIColor.white.cgColor
        } else {
            view.backgroundColor = LIGHT_APPEARANCE
            selectStateButton.setTitleColor(.black, for: .normal)
            selectStateButton.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        }
    }
    
    func configureNavigationBar() {
        title = "Tax Helper"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTappedInfoButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "questionmark.circle")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(didTappedQuestionMarkButton)
        )
    }
    
    func settingDelegate() {
        priceTextField.delegate = self
        taxTextField.delegate = self
    }
}


// MARK: - Actions
private extension MainScreenViewController {
    
    func setupAction() {
        let selectStateAction = UIAction { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.stateSelection()
        }
        
        selectStateButton.addAction(selectStateAction, for: .touchUpInside)
        
        let calculateAction = UIAction { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.calculateTotalPrice()
        }
        
        calculateButton.addAction(calculateAction, for: .touchUpInside)
        
        let resetAction = UIAction { [weak self] _ in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.resetValues()
            }
        }
        
        resetButton.addAction(resetAction, for: .touchUpInside)
    }
    
    func stateSelection() {
        let statePickerVC = StatePickerViewController()
        let nav = UINavigationController(rootViewController: statePickerVC)
        
        statePickerVC.didSelectStateTax = { [weak self] (taxRate, state) in
            guard let strongSelf = self else { return }
            
            strongSelf.updateTextFieldState(
                strongSelf.taxTextField,
                withText: "\(taxRate)",
                borderColor: ACTIVE_STATE_COLOR
            )
            
            strongSelf.updateButtonState(
                strongSelf.selectStateButton,
                title: "\(state)",
                titleColor: .black,
                backgroundColor: .white
            )
            self?.selectStateButton.layer.borderColor = UIColor.black.cgColor
            
            self?.resetButton.isHidden = false
        }
        
        nav.modalPresentationStyle = .custom
        
        nav.transitioningDelegate = self
        
        present(nav, animated: true)
    }
    
    func calculateTotalPrice() {
        guard let price = Double(priceTextField.text ?? "") else { return }
        guard let taxRate = Double(taxTextField.text ?? "") else { return }

        let totalTaxes = price * (taxRate / 100)
        let totalPrice = price + totalTaxes
        
        updateLabelState(
            totalPriceValueLabel,
            text: String(format: "%.2f", totalPrice),
            textColor: .label,
            borderColor: ACTIVE_STATE_COLOR
        )
        
        updateButtonState(
            calculateButton,
            title: "CALCULATED",
            titleColor: .white,
            backgroundColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        )
        
        updateButtonState(
            resetButton,
            title: "RESET",
            titleColor: .white,
            backgroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        )
    }
    
    func resetValues() {
        updateLabelState(
            totalPriceValueLabel,
            text: "﹩",
            textColor: .tertiaryLabel,
            borderColor: NOT_ACTIVE_STATE_COLOR
        )
        
        updateTextFieldState(
            priceTextField,
            withText: "",
            placeholder: "﹩",
            borderColor: NOT_ACTIVE_STATE_COLOR
        )
        
        updateTextFieldState(
            taxTextField,
            withText: "",
            placeholder: "﹪",
            borderColor: NOT_ACTIVE_STATE_COLOR
        )
        
        updateButtonState(
            calculateButton,
            title: "CALCULATE",
            titleColor: .white,
            backgroundColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        )
        
        updateButtonState(
            selectStateButton,
            title: "Pick a state ⠆",
            titleColor: UIColor.black,
            backgroundColor: .clear
        )
        resetButton.isHidden = true
        updateAppearance(for: traitCollection)
    }
    
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
    
    @objc func didTappedInfoButton() {
        let rootVC = InfoViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    @objc func didTappedQuestionMarkButton() {
        let rootVC = FAQViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
}


// MARK: - UI State Update Helpers
extension MainScreenViewController {
    
    func updateTextFieldState(
        _ textField: UITextField,
        withText text: String,
        placeholder: String = "",
        borderColor: UIColor
    ) {
        textField.text = text
        textField.placeholder = placeholder
        textField.layer.borderColor = borderColor.cgColor
    }
    
    func updateButtonState(
        _ button: UIButton,
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor
    ) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
    }
    
    func updateLabelState(
        _ label: UILabel,
        text: String,
        textColor: UIColor,
        borderColor: UIColor
    ) {
        label.text = text
        label.textColor = textColor
        label.layer.borderColor = borderColor.cgColor
    }
}


// MARK: - UITextFieldDelegate
extension MainScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = ACTIVE_STATE_COLOR.cgColor
        textField.placeholder = nil
        resetButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.layer.borderColor = NOT_ACTIVE_STATE_COLOR.cgColor
            if textField == priceTextField {
                textField.placeholder = "﹩"
            } else if textField == taxTextField {
                textField.placeholder = "﹪"
            }
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

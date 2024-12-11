import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var grossPriceLabel = createLabel(
        text: "Gross price",
        fontSize: 16,
        weight: .medium
    )
    
    private lazy var totalPriceValueLabel = createLabel(
        text: "﹩",
        fontSize: 18,
        textColor: .tertiaryLabel,
        borderColor: INACTIVE_FIELD.cgColor,
        borderWidth: 1.5,
        cornerRadius: 7
    )
    
    private lazy var netPriceLabel = createLabel(
        text: "Net price",
        fontSize: 16,
        weight: .medium
    )
    
    private lazy var priceTextField = createTextField(
        placeholder: "﹩",
        borderColor: INACTIVE_FIELD.cgColor
    )
    
    private lazy var salesTaxLabel = createLabel(
        text: "Sales tax",
        fontSize: 16,
        weight: .medium
    )
    
    private lazy var taxTextField = createTextField(
        placeholder: "﹪",
        borderColor: INACTIVE_FIELD.cgColor,
        isUserInteractionEnabled: false
    )
    
    private lazy var taxExplanationLabel = createLabel(
        text: "Automatically appears in the field based on the state you select.",
        fontSize: 11,
        weight: .light,
        textColor: .secondaryLabel,
        numberOfLines: 2
    )
    
    private lazy var selectStateButton = createButton(
        title: "Pick a state ⠆",
        titleColor: .label
    )
    
    private lazy var calculateButton = createButton(
        title: "CALCULATE",
        titleColor: .label,
        backgroundColor: .systemBlue
    )
    
    private lazy var resetButton = createButton(
        title: "RESET",
        titleColor: .label,
        backgroundColor: .systemRed,
        isHidden: true
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        configureNavigationBar()
        settingDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateAppearance(for: traitCollection)
    }
}


// MARK: - UI Setup
private extension MainScreenViewController {
    
    func setupUI() {
        let components = [
            grossPriceLabel,
            totalPriceValueLabel,
            netPriceLabel,
            priceTextField,
            salesTaxLabel,
            taxTextField,
            taxExplanationLabel,
            selectStateButton,
            calculateButton,
            resetButton
        ]
        components.forEach { view.addSubview($0) }
        setupConstraints()
        addDoneButtonTo(priceTextField)
        addDoneButtonTo(taxTextField)
    }
    
    func setupConstraints() {
        grossPriceLabel.setConstraint(
            top: view.safeAreaLayoutGuide.topAnchor,
            topConstant: 26,
            leading: totalPriceValueLabel.leadingAnchor,
            height: BASE_HEIGHT
        )
        
        totalPriceValueLabel.setConstraint(
            top: grossPriceLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: BASE_HEIGHT
        )
        
        netPriceLabel.setConstraint(
            top: totalPriceValueLabel.bottomAnchor,
            topConstant: 10,
            leading: totalPriceValueLabel.leadingAnchor,
            height: BASE_HEIGHT
        )
        
        priceTextField.setConstraint(
            top: netPriceLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: BASE_HEIGHT
        )
        
        salesTaxLabel.setConstraint(
            top: priceTextField.bottomAnchor,
            topConstant: 10,
            leading: totalPriceValueLabel.leadingAnchor,
            height: BASE_HEIGHT
        )
        
        taxTextField.setConstraint(
            top: salesTaxLabel.bottomAnchor,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: BASE_HEIGHT
        )
        
        taxExplanationLabel.setConstraint(
            top: taxTextField.bottomAnchor,
            topConstant: 4,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER
        )
        
        selectStateButton.setConstraint(
            top: taxExplanationLabel.bottomAnchor,
            topConstant: 20,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: HEIGHT_ANCHOR
        )
        
        calculateButton.setConstraint(
            top: selectStateButton.bottomAnchor,
            topConstant: 30,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: HEIGHT_ANCHOR
        )
        
        resetButton.setConstraint(
            top: calculateButton.bottomAnchor,
            topConstant: 10,
            centerX: view.centerXAnchor,
            widthMultiplier: BASE_MULTIPLIER,
            height: HEIGHT_ANCHOR
        )
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
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            selectStateButton.layer.borderColor = UIColor.white.cgColor
            calculateButton.layer.borderColor = UIColor.white.cgColor
            resetButton.layer.borderColor = UIColor.white.cgColor
        } else {
            view.backgroundColor = .white
            selectStateButton.layer.borderColor = UIColor.black.cgColor
            calculateButton.layer.borderColor = UIColor.black.cgColor
            resetButton.layer.borderColor = UIColor.black.cgColor
        }
    }
}


// MARK: - Actions
private extension MainScreenViewController {
    
    func calculateTotalPrice() {
        guard let price = Double(priceTextField.text ?? "") else { return }
        guard let taxRate = Double(taxTextField.text ?? "") else { return }

        let totalTaxes = price * (taxRate / 100)
        let totalPrice = price + totalTaxes
        
        updateLabelState(
            totalPriceValueLabel,
            text: String(format: "%.2f", totalPrice),
            textColor: .label,
            borderColor: ACTIVE_FIELD
        )
        
        updateButtonState(
            calculateButton,
            title: "CALCULATED",
            titleColor: .label,
            backgroundColor: .systemBlue
        )
        
        updateButtonState(
            resetButton,
            title: "RESET",
            titleColor: .label,
            backgroundColor: .systemRed
        )
    }
    
    func setupActions() {
        selectStateButton.addAction(UIAction { [weak self] _ in
            self?.presentStatePicker()
        }, for: .touchUpInside)
        
        calculateButton.addAction(UIAction { [weak self] _ in
            self?.calculateTotalPrice()
        }, for: .touchUpInside)
        
        resetButton.addAction(UIAction { [weak self] _ in
            self?.resetValues()
        }, for: .touchUpInside)
    }
    
    func presentStatePicker() {
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
    
    func updateStateOnTaxSelection(taxRate: Double, state: String) {
        updateTextFieldState(
            taxTextField,
            withText: "\(taxRate)",
            borderColor: ACTIVE_FIELD
        )
        updateButtonState(
            selectStateButton,
            title: "\(state)",
            titleColor: .label,
            backgroundColor: .systemBackground
        )
        resetButton.isHidden = false
    }
    
    func resetValues() {
        updateLabelState(
            totalPriceValueLabel,
            text: "﹩",
            textColor: .tertiaryLabel,
            borderColor: INACTIVE_FIELD
        )
        updateTextFieldState(
            priceTextField,
            withText: "",
            placeholder: "﹩",
            borderColor: INACTIVE_FIELD
        )
        updateTextFieldState(
            taxTextField,
            withText: "",
            placeholder: "﹪",
            borderColor: INACTIVE_FIELD
        )
        updateButtonState(
            calculateButton,
            title: "CALCULATE",
            titleColor: .label,
            backgroundColor: .systemBlue
        )
        updateButtonState(
            selectStateButton,
            title: "Pick a state ⠆",
            titleColor: .label
        )
        resetButton.isHidden = true
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
        backgroundColor: UIColor? = nil
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
        textField.layer.borderColor = ACTIVE_FIELD.cgColor
        textField.placeholder = nil
        resetButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.layer.borderColor = INACTIVE_FIELD.cgColor
            textField.placeholder = (textField == priceTextField ? "﹩" : "﹪")
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


// MARK: - Component Factory
private extension MainScreenViewController {
    
    func createLabel(
        text: String,
        fontSize: CGFloat,
        weight: UIFont.Weight = .regular,
        textColor: UIColor = .label,
        borderColor: CGColor? = nil,
        borderWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        numberOfLines: Int = 1
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = FontManager.shared.labelFont(withSize: fontSize, withWeight: weight)
        label.textColor = textColor
        label.layer.borderColor = borderColor
        label.layer.borderWidth = borderWidth
        label.layer.cornerRadius = cornerRadius
        label.layer.masksToBounds = cornerRadius > 0
        label.numberOfLines = numberOfLines
        label.textAlignment = .center
        return label
    }
    
    func createTextField(
        placeholder: String,
        borderColor: CGColor,
        isUserInteractionEnabled: Bool = true
    ) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.layer.cornerRadius = 7
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = borderColor
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        textField.font = FontManager.shared.labelFont(withSize: 18)
        textField.keyboardType = .decimalPad
        return textField
    }
    
    func createButton(
        title: String,
        titleColor: UIColor,
        backgroundColor: UIColor = .systemBackground,
        borderColor: CGColor? = nil,
        isHidden: Bool = false
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1.5
        button.layer.borderColor = borderColor
        button.isHidden = isHidden
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 16, withWeight: .bold)
        return button
    }
}

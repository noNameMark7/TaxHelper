import UIKit

protocol MainScreenViewDelegate: AnyObject {
    func selectStateButtonTapped()
    func calculateButtonTapped()
    func resetButtonTapped()
}

class MainScreenView: UIView {
    
    // MARK: - Delegate
    weak var delegate: MainScreenViewDelegate?
    
    // MARK: - Properties
    var taxExplanationLabelTopConstraint: NSLayoutConstraint!
    var selectStateButtonTopToLabelConstraint: NSLayoutConstraint!
    var selectStateButtonTopToTextFieldConstraint: NSLayoutConstraint!

    
    // MARK: - UI Components
    private let grossPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.grossPrice.rawValue
        label.font = FontManager.shared.labelFont(withSize: 16)
        return label
    }()
    
    private lazy var totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.dollarSign.rawValue
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 6
        label.layer.borderColor = UIColor.inactiveField.cgColor
        return label
    }()
        
    private let netPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.netPrice.rawValue
        label.font = FontManager.shared.labelFont(withSize: 16)
        return label
    }()
    
    lazy var netPriceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        textField.placeholder = TextValues.dollarSign.rawValue
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.inactiveField.cgColor
        textField.keyboardType = .default
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    private let salesTaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.salesTax.rawValue
        label.font = FontManager.shared.labelFont(withSize: 16)
        return label
    }()
    
    lazy var taxTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        textField.placeholder = TextValues.salesTaxPercent.rawValue
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.inactiveField.cgColor
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let taxExplanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontManager.shared.labelFont(withSize: 11, withWeight: .light)
        label.text = TextValues.taxExplanation.rawValue
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var selectStateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.setTitle(TextValues.pickAState.rawValue, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .clear
        return button
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.setTitle(TextValues.calculate.rawValue, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        button.setTitle(TextValues.reset.rawValue, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemRed
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            applyTheme()
        }
    }
}

// MARK: - UI Setup
private extension MainScreenView {
    
    func setupUI() {
        [
            grossPriceLabel,
            totalPriceValueLabel,
            netPriceLabel,
            netPriceTextField,
            salesTaxLabel,
            taxTextField,
            taxExplanationLabel,
            selectStateButton,
            calculateButton,
            resetButton
        ].forEach { addSubview($0) }
   
        setupConstraints()
        applyTheme()
    }
    
    func setupConstraints() {
        // TaxExplanationLabel Constraints
        taxExplanationLabelTopConstraint = taxExplanationLabel.topAnchor.constraint(
            equalTo: taxTextField.bottomAnchor, constant: 4
        )
        
        taxExplanationLabelTopConstraint.isActive = true
        
        // SelectStateButton Constraints
        selectStateButtonTopToLabelConstraint = selectStateButton.topAnchor.constraint(
            equalTo: taxExplanationLabel.bottomAnchor, constant: 20
        )
        
        selectStateButtonTopToTextFieldConstraint = selectStateButton.topAnchor.constraint(
            equalTo: taxTextField.bottomAnchor, constant: 20
        )
        
        // Activate the default constraint
        selectStateButtonTopToLabelConstraint.isActive = true

        grossPriceLabel.setConstraint(
            top: safeAreaLayoutGuide.topAnchor,
            topConstant: 26,
            leading: totalPriceValueLabel.leadingAnchor,
            height: LayoutConstants.baseHeight
        )
        
        totalPriceValueLabel.setConstraint(
            top: grossPriceLabel.bottomAnchor,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.baseHeight
        )
        
        netPriceLabel.setConstraint(
            top: totalPriceValueLabel.bottomAnchor,
            topConstant: 10,
            leading: totalPriceValueLabel.leadingAnchor,
            height: LayoutConstants.baseHeight
        )
        
        netPriceTextField.setConstraint(
            top: netPriceLabel.bottomAnchor,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.baseHeight
        )
        
        salesTaxLabel.setConstraint(
            top: netPriceTextField.bottomAnchor,
            topConstant: 10,
            leading: totalPriceValueLabel.leadingAnchor,
            height: LayoutConstants.baseHeight
        )
        
        taxTextField.setConstraint(
            top: salesTaxLabel.bottomAnchor,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.baseHeight
        )
        
        taxExplanationLabel.setConstraint(
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier
        )
        
        selectStateButton.setConstraint(
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.heightAnchor
        )
        
        calculateButton.setConstraint(
            top: selectStateButton.bottomAnchor,
            topConstant: 30,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.heightAnchor
        )
        
        resetButton.setConstraint(
            top: calculateButton.bottomAnchor,
            topConstant: 10,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.heightAnchor
        )
    }
    
    func applyTheme() {
        let theme = (traitCollection.userInterfaceStyle == .dark)
        ? ThemeManager.dark
        : ThemeManager.light
        
        backgroundColor = theme.backgroundColor
   
        grossPriceLabel.textColor = theme.primaryTextColor
        netPriceLabel.textColor = theme.primaryTextColor
        salesTaxLabel.textColor = theme.primaryTextColor
        taxExplanationLabel.textColor = theme.secondaryTextColor
        
        totalPriceValueLabel.textColor = theme.tertiaryTextColor
        totalPriceValueLabel.layer.borderColor = theme.inactiveFieldBorderColor.cgColor
        
        netPriceTextField.layer.borderColor = theme.inactiveFieldBorderColor.cgColor
        taxTextField.layer.borderColor = theme.inactiveFieldBorderColor.cgColor
        
        selectStateButton.setTitleColor(theme.primaryTextColor, for: .normal)
        selectStateButton.layer.borderColor = theme.borderColor.cgColor
        calculateButton.layer.borderColor = theme.borderColor.cgColor
        resetButton.layer.borderColor = theme.borderColor.cgColor
    }
}

// MARK: - Actions
extension MainScreenView {
    
    private func setupActions() {
        selectStateButton.addAction(
            UIAction { [weak self] _ in
                self?.handleSelectStateTapped()
            }, for: .touchUpInside
        )
        
        calculateButton.addAction(
            UIAction { [weak self] _ in
                self?.handleCalculateTapped()
            }, for: .touchUpInside
        )
        
        resetButton.addAction(
            UIAction { [weak self] _ in
                self?.handleResetTapped()
            }, for: .touchUpInside
        )
    }
    
    private func handleSelectStateTapped() {
        delegate?.selectStateButtonTapped()
    }
    
    private func handleCalculateTapped() {
        delegate?.calculateButtonTapped()
    }
    
    private func handleResetTapped() {
        delegate?.resetButtonTapped()
    }
    
    public func updateUIState(for mode: UIState) {
        switch mode {
        case .normal:
            updateLabelState(
                totalPriceValueLabel,
                text: TextValues.dollarSign.rawValue,
                textColor: .tertiaryLabel,
                borderColor: UIColor.inactiveField
            )
            updateTextFieldState(
                netPriceTextField,
                withText: "",
                placeholder: TextValues.dollarSign.rawValue,
                borderColor:  UIColor.inactiveField
            )
            updateTextFieldState(
                taxTextField,
                withText: "",
                placeholder: TextValues.salesTaxPercent.rawValue,
                borderColor:  UIColor.inactiveField
            )
            updateButtonState(
                calculateButton,
                title: TextValues.calculate.rawValue,
                backgroundColor: .systemBlue
            )
            updateButtonState(
                selectStateButton,
                title: TextValues.pickAState.rawValue
            )
            updatingComponentsToInitialStates()
            
        case .calculate(let totalPrice):
            updateLabelState(
                totalPriceValueLabel,
                text: totalPrice,
                textColor: .label,
                borderColor: UIColor.activeField
            )
            
            updateButtonState(
                calculateButton,
                title: TextValues.calculated.rawValue,
                backgroundColor: .systemBlue
            )
            
            updateButtonState(
                resetButton,
                title: TextValues.reset.rawValue,
                backgroundColor: .systemRed
            )
            resetButton.isHidden = false
        }
    }
    
    private func updatingComponentsToInitialStates() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Step 1: Animate the buttons moving down
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.resetButton.isHidden = true
                self.selectStateButtonTopToTextFieldConstraint.isActive = false
                self.selectStateButtonTopToLabelConstraint.isActive = true
                self.layoutIfNeeded()
            }) { _ in
                // Step 2: Show the label after the buttons have finished moving
                self.taxExplanationLabel.alpha = 0.0
                self.taxExplanationLabel.isHidden = false
                UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn) {
                    self.taxExplanationLabel.alpha = 1.0
                    self.layoutIfNeeded()
                }
            }
        }
    }
}

// MARK: - State Updates
extension MainScreenView {
    
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
        backgroundColor: UIColor? = nil
    ) {
        button.setTitle(title, for: .normal)
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

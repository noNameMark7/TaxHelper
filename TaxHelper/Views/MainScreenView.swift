import UIKit

protocol MainScreenViewDelegate: AnyObject {
    func selectStateButtonTapped()
    func calculateButtonTapped()
    func resetButtonTapped()
}

class MainScreenView: UIView {
    
    // MARK: - Delegate
    weak var delegate: MainScreenViewDelegate?
    
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
    
    lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        textField.placeholder = TextValues.dollarSign.rawValue
        textField.textAlignment = .center
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 6
        textField.layer.borderColor = UIColor.inactiveField.cgColor
        textField.keyboardType = .decimalPad
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
extension MainScreenView {
    
    private func setupUI() {
        [
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
        ].forEach { addSubview($0) }
   
        setupConstraints()
        applyTheme()
    }
    
    private func setupConstraints() {
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
        
        priceTextField.setConstraint(
            top: netPriceLabel.bottomAnchor,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier,
            height: LayoutConstants.baseHeight
        )
        
        salesTaxLabel.setConstraint(
            top: priceTextField.bottomAnchor,
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
            top: taxTextField.bottomAnchor,
            topConstant: 4,
            centerX: centerXAnchor,
            widthMultiplier: LayoutConstants.baseMultiplier
        )
        
        selectStateButton.setConstraint(
            top: taxExplanationLabel.bottomAnchor,
            topConstant: 20,
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
    
    private func applyTheme() {
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
        
        priceTextField.layer.borderColor = theme.inactiveFieldBorderColor.cgColor
        taxTextField.layer.borderColor = theme.inactiveFieldBorderColor.cgColor
        
        selectStateButton.setTitleColor(theme.primaryTextColor, for: .normal)
        selectStateButton.layer.borderColor = theme.borderColor.cgColor
        calculateButton.layer.borderColor = theme.borderColor.cgColor
        resetButton.layer.borderColor = theme.borderColor.cgColor
    }
}

// MARK: - Actions
private extension MainScreenView {
    
    func setupActions() {
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
    
    func handleSelectStateTapped() {
        delegate?.selectStateButtonTapped()
    }
    
    func handleCalculateTapped() {
        delegate?.calculateButtonTapped()
    }
    
    func handleResetTapped() {
        delegate?.resetButtonTapped()
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
    
    func updateUIState(for mode: UIState) {
        switch mode {
        case .normal:
            updateLabelState(
                totalPriceValueLabel,
                text: TextValues.dollarSign.rawValue,
                textColor: .tertiaryLabel,
                borderColor: UIColor.inactiveField
            )
            updateTextFieldState(
                priceTextField,
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
            resetButton.isHidden = true
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
}

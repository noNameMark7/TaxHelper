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
    lazy var grossPriceLabel = createLabel(
        text: "Gross price",
        fontSize: 16,
        weight: .medium
    )
    
    lazy var totalPriceValueLabel = createLabel(
        text: "﹩",
        fontSize: 18,
        textColor: .tertiaryLabel,
        borderColor: UIColor.inactiveField.cgColor,
        borderWidth: 1.5,
        cornerRadius: 7
    )
    
    lazy var netPriceLabel = createLabel(
        text: "Net price",
        fontSize: 16,
        weight: .medium
    )
    
    lazy var priceTextField = createTextField(
        placeholder: "﹩",
        borderColor: UIColor.inactiveField.cgColor
    )
    
    lazy var salesTaxLabel = createLabel(
        text: "Sales tax",
        fontSize: 16,
        weight: .medium
    )
    
    lazy var taxTextField = createTextField(
        placeholder: "﹪",
        borderColor: UIColor.inactiveField.cgColor,
        isUserInteractionEnabled: false
    )
    
    lazy var taxExplanationLabel = createLabel(
        text: "Automatically appears in the field based on the state you select.",
        fontSize: 11,
        weight: .light,
        textColor: .secondaryLabel,
        numberOfLines: 2
    )
    
    lazy var selectStateButton = createButton(
        title: "Pick a state ⠆",
        titleColor: .label
    )
    
    lazy var calculateButton = createButton(
        title: "CALCULATE",
        titleColor: .label,
        backgroundColor: .systemBlue
    )
    
    lazy var resetButton = createButton(
        title: "RESET",
        titleColor: .label,
        backgroundColor: .systemRed,
        isHidden: true
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup
extension MainScreenView {
    
    private func setupUI() {
        backgroundColor = .systemBackground
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
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            [
                selectStateButton,
                calculateButton,
                resetButton
            ].forEach { component in
                component.layer.borderColor = UIColor.white.cgColor
            }
        } else {
            [
                selectStateButton,
                calculateButton,
                resetButton
            ].forEach { component in
                component.layer.borderColor = UIColor.black.cgColor
            }
        }
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

// MARK: - Helpers
extension MainScreenView {
    
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
    
    func updateUIState(for mode: UIState) {
        switch mode {
        case .normal:
            updateLabelState(
                totalPriceValueLabel,
                text: "﹩",
                textColor: .tertiaryLabel,
                borderColor: UIColor.inactiveField
            )
            updateTextFieldState(
                priceTextField,
                withText: "",
                placeholder: "﹩",
                borderColor: UIColor.inactiveField
            )
            updateTextFieldState(
                taxTextField,
                withText: "",
                placeholder: "﹪",
                borderColor: UIColor.inactiveField
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
            
        case .calculate(let totalPrice):
            updateLabelState(
                totalPriceValueLabel,
                text: totalPrice,
                textColor: .label,
                borderColor: UIColor.activeField
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
            resetButton.isHidden = false
        }
    }
}

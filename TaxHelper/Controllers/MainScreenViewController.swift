import UIKit

// MARK: - MainScreenViewController

class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private var stateTaxes: [StateTax] = []
    
    private var selectedStateTax: Double = 0.0
    
    private let grossPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gross price"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let totalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "USD"
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1.5
        label.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .medium)
        label.textColor = .tertiaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let netPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Net price"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "USD"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 7
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        textField.keyboardType = .decimalPad
        textField.font = FontManager.shared.labelFont(withSize: 18, withWeight: .medium)
        return textField
    }()
    
    private let salesTaxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sales tax"
        label.font = FontManager.shared.labelFont(withSize: 16, withWeight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private let taxTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "%"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 7
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        textField.isUserInteractionEnabled = false
        textField.font = FontManager.shared.labelFont(withSize: 18, withWeight: .medium)
        return textField
    }()
    
    private let taxTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The tax automatically appears in the field based on the state you select"
        label.font = FontManager.shared.labelFont(withSize: 12, withWeight: .light)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let selectStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please click to select state ‣"
        label.font = FontManager.shared.labelFont(withSize: 18, withWeight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let statePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CALCULATE", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 20, withWeight: .bold)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.5
        button.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.titleLabel?.font = FontManager.shared.labelFont(withSize: 20, withWeight: .bold)
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1.5
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
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
        view.addSubview(taxTextFieldDescriptionLabel)
        view.addSubview(selectStateLabel)
        view.addSubview(statePickerView)
        view.addSubview(calculateButton)
        view.addSubview(resetButton)
        
        addDoneButtonTo(priceTextField)
        addDoneButtonTo(taxTextField)
        
        configureUI()
        setupAction()
        settingDelegate()
        loadValuesFromJSON()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let baseHeight: CGFloat = 36
        let baseMultiplier: CGFloat = 0.6
        
        NSLayoutConstraint.activate([
            grossPriceLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            grossPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 26),
            grossPriceLabel.heightAnchor.constraint(equalToConstant: baseHeight),
            
            totalPriceValueLabel.topAnchor.constraint(equalTo: grossPriceLabel.bottomAnchor),
            totalPriceValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalPriceValueLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            totalPriceValueLabel.heightAnchor.constraint(equalToConstant: baseHeight),
            
            netPriceLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            netPriceLabel.topAnchor.constraint(equalTo: totalPriceValueLabel.bottomAnchor, constant: 10),
            netPriceLabel.heightAnchor.constraint(equalToConstant: baseHeight),
            
            priceTextField.topAnchor.constraint(equalTo: netPriceLabel.bottomAnchor),
            priceTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            priceTextField.heightAnchor.constraint(equalToConstant: baseHeight),
            
            salesTaxLabel.leadingAnchor.constraint(equalTo: totalPriceValueLabel.leadingAnchor),
            salesTaxLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 10),
            salesTaxLabel.heightAnchor.constraint(equalToConstant: baseHeight),
            
            taxTextField.topAnchor.constraint(equalTo: salesTaxLabel.bottomAnchor),
            taxTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taxTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            taxTextField.heightAnchor.constraint(equalToConstant: baseHeight),
            
            taxTextFieldDescriptionLabel.topAnchor.constraint(equalTo: taxTextField.bottomAnchor, constant: 4),
            taxTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taxTextFieldDescriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            
            selectStateLabel.topAnchor.constraint(equalTo: taxTextFieldDescriptionLabel.bottomAnchor, constant: 20),
            selectStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statePickerView.topAnchor.constraint(equalTo: selectStateLabel.bottomAnchor),
            statePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statePickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            statePickerView.heightAnchor.constraint(equalToConstant: 120),
            
            calculateButton.topAnchor.constraint(equalTo: statePickerView.bottomAnchor, constant: 20),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            
            resetButton.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 12),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: baseMultiplier),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configureNavigationBar() {
        title = "Sales Tax Calculator"
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
        statePickerView.delegate = self
        statePickerView.dataSource = self
        taxTextField.inputView = statePickerView
        priceTextField.delegate = self
        taxTextField.delegate = self
    }
}


// MARK: - Actions

private extension MainScreenViewController {
    
    func setupAction() {
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
    
    func calculateTotalPrice() {
        guard let price = Double(priceTextField.text ?? "") else { return }
        
        let totalTaxes = price * (selectedStateTax / 100)
        let totalPrice = price + totalTaxes
        let formattedTotalPrice = String(format: "$%.2f", totalPrice)
        updateTotalPriceLabel(with: formattedTotalPrice)
    }
    
    func updateTotalPriceLabel(with value: String) {
        totalPriceValueLabel.text = value
        totalPriceValueLabel.textColor = .label
        totalPriceValueLabel.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor
    }
    
    func resetValues() {
        totalPriceValueLabel.text = "USD"
        totalPriceValueLabel.textColor = .tertiaryLabel
        totalPriceValueLabel.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        
        priceTextField.text = nil
        priceTextField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        priceTextField.placeholder = "USD"
        
        taxTextField.text = nil
        taxTextField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
        taxTextField.placeholder = "%"
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
    
    func loadStateTaxes() -> [StateTax]? {
        guard let url = Bundle.main.url(forResource: "state_taxes", withExtension: "json") else {
            print("Failed to find state_taxes.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let stateTaxes = try decoder.decode([StateTax].self, from: data)
            return stateTaxes
        } catch {
            print("Error loading state taxes: \(error)")
            return nil
        }
    }
    
    func loadValuesFromJSON() {
        if let loadedStateTaxes = loadStateTaxes() {
            stateTaxes = loadedStateTaxes
            print("Loaded state taxes: \(stateTaxes)")
        } else {
            print("Failed to load state taxes.")
        }
    }
    
    @objc func didTappedInfoButton() {
        let vc = InfoViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
    
    @objc func didTappedQuestionMarkButton() {
        let vc = FAQViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true)
    }
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension MainScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        stateTaxes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        stateTaxes[row].state
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedState = stateTaxes[row]
        selectedStateTax = selectedState.taxRate
        taxTextField.text = "\(selectedState.taxRate)"
        taxTextField.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor
    }
}


// MARK: - UITextFieldDelegate

extension MainScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.layer.borderColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.5).cgColor
            if textField == priceTextField {
                textField.placeholder = "USD"
            } else if textField == taxTextField {
                textField.placeholder = "%"
            }
        }
    }
}

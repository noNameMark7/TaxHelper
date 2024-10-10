import UIKit

// MARK: - StatePickerViewController

class StatePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    private var stateTaxes: [StateTax] = []
    
    private var selectedStateTax: Double = 0.0
    
    private let statePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        initialSetup()
    }
}


// MARK: - Initial setup

private extension StatePickerViewController {
    
    func initialSetup() {
        configureUI()
        settingDelegate()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(statePickerView)
        
        NSLayoutConstraint.activate([
            statePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statePickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statePickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            statePickerView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    func settingDelegate() {
        statePickerView.delegate = self
        statePickerView.dataSource = self
    }
}


// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension StatePickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
//        taxTextField.text = "\(selectedState.taxRate)"
//        taxTextField.layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1).cgColor
    }
}

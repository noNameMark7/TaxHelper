import UIKit

class StatePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    var stateTaxes: [StateTax] = []
    
    // Closure to pass selected tax rate and state
    var didSelectStateTax: ((Double, String) -> Void)?
    
    private let statePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadValuesFromJSON()
        
        guard let screenHeight = view.window?.windowScene?.screen.bounds.height else { return }
        guard let screenWidth = view.window?.windowScene?.screen.bounds.width else { return }
        
        preferredContentSize = CGSize(
            width: screenWidth,
            height: screenHeight / 2.8
        )
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance(for: traitCollection)
    }
}


// MARK: - Initial setup

private extension StatePickerViewController {
    
    func initialSetup() {
        configureUI()
        configureNavigationBar()
        settingDelegate()
    }
    
    func configureUI() {
        view.addSubview(statePickerView)
        
        NSLayoutConstraint.activate([
            statePickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statePickerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            statePickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = DARK_APPEARANCE
        } else {
            view.backgroundColor = LIGHT_APPEARANCE
        }
    }
    
    func configureNavigationBar() {
        title = "State selection"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTappedSaveButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTappedCloseButton)
        )
    }
    
    func settingDelegate() {
        statePickerView.delegate = self
        statePickerView.dataSource = self
    }
    
    @objc func didTappedSaveButton() {
        let selectedRow = statePickerView.selectedRow(inComponent: 0)
        let selectedState = stateTaxes[selectedRow]
        print("\(selectedState.taxRate) % tax in \(selectedState.state)")
        didSelectStateTax?(selectedState.taxRate, selectedState.state)
        dismiss(animated: true)
    }
    
    @objc func didTappedCloseButton() {
        dismiss(animated: true)
    }
}


// MARK: - Populate data

extension StatePickerViewController {
    
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
}

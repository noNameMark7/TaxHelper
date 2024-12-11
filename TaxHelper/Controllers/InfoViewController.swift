import UIKit

class InfoViewController: UIViewController {
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let designationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.designationLabel.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let designationsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.designationText.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.textColor = .label
        textView.backgroundColor = .systemBackground
        return textView
    }()
    
    private let salesTaxDefinitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.salesTaxDefinitionLabel.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let salesTaxDefinitionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.salesTaxDefinitionText.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.textColor = .label
        textView.backgroundColor = .systemBackground
        return textView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateAppearance(for: traitCollection)
    }
}

// MARK: - UI Setup
private extension InfoViewController {
    
    func setupUI() {
        setupConstraints()
        configureNavigationBar()
    }
    
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let components = [
            designationsLabel,
            designationsTextView,
            salesTaxDefinitionLabel,
            salesTaxDefinitionTextView
        ]
        components.forEach { contentView.addSubview($0) }
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let designationsLabelConstraints = [
            designationsLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            designationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let designationsTextViewConstraints = [
            designationsTextView.topAnchor.constraint(equalTo: designationsLabel.bottomAnchor, constant: 8),
            designationsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            designationsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let salesTaxDefinitionLabelConstraints = [
            salesTaxDefinitionLabel.topAnchor.constraint(equalTo: designationsTextView.bottomAnchor, constant: 24),
            salesTaxDefinitionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let salesTaxDefinitionTextViewConstraints = [
            salesTaxDefinitionTextView.topAnchor.constraint(equalTo: salesTaxDefinitionLabel.bottomAnchor, constant: 8),
            salesTaxDefinitionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            salesTaxDefinitionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            salesTaxDefinitionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(designationsLabelConstraints)
        NSLayoutConstraint.activate(designationsTextViewConstraints)
        NSLayoutConstraint.activate(salesTaxDefinitionLabelConstraints)
        NSLayoutConstraint.activate(salesTaxDefinitionTextViewConstraints)
        
        scrollView.contentSize = contentView.bounds.size
    }
    
    func configureNavigationBar() {
        title = "Info"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTappedDoneButton)
        )
    }
    
    @objc func didTappedDoneButton() {
        dismiss(animated: true)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            [
                designationsTextView,
                salesTaxDefinitionTextView
            ].forEach { component in
                component.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            }
        } else {
            view.backgroundColor = .white
            [
                designationsTextView,
                salesTaxDefinitionTextView
            ].forEach { component in
                component.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
        }
    }
}

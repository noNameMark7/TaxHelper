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
        label.text = "Designations"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let designationsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.textColor = .label
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        Net price - the price of the product before the sales tax is applied.\n
        Sales tax - the sales tax that the government charges on the retail price of a product.\n
        Gross price - the price of the product after the sales tax is applied.
        """
        return textView
    }()
    
    private let salesTaxDefinitionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sales tax definition"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let salesTaxDefinitionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.textColor = .label
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        Sales tax is a consumption-based tax that is indirectly charged on the consumer at the point of final purchase of a good or service.The indirect feature of the tax means that the consumer bears the burden of the tax, however it's collected and transferred to authorities by the seller. The most popular type of sales tax is the retail sales tax which is present on state-level in the United States. Under such a taxation framework, consumers pay the price of the item plus the amount of the sales tax which is collected by the store at the cash register and printed on the receipt. In the next section, you can get more insight into its concept as we illustrate the difference between the sales tax and value-added tax.
        """
        return textView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance(for: traitCollection)
    }
}


// MARK: - Initial setup
private extension InfoViewController {
    
    func initialSetup() {
        configureUI()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(designationsLabel)
        contentView.addSubview(designationsTextView)
        contentView.addSubview(salesTaxDefinitionLabel)
        contentView.addSubview(salesTaxDefinitionTextView)
        
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
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = DARK_APPEARANCE
            designationsTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
            salesTaxDefinitionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
        } else {
            view.backgroundColor = LIGHT_APPEARANCE
            
        }
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
}

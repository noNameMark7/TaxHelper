import UIKit

class FAQViewController: UIViewController {

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
    
    private let firstQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "How to calculate it?"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let firstQuestionTextView: UITextView = {
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
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        1. Find out the sales tax rate, an example will be the state of Oklahoma, in which 4.5%.\n
        2. Find out the net price of a product. Let's use $1299.\n
        3. Multiply your net price by 4.5%, so by 0.045, to find out the tax amount: 1299 * 0.045 = 58.45.\n
        4. Add the tax amount to the net price to find out the gross price: 1299 + 58.45 = 1357.45.
        """
        return textView
    }()
    
    private let secondQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What states don’t have it?"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let secondQuestionTextView: UITextView = {
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
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        Alaska, Delaware, Montana, New Hampshire and Oregon all do not have a statewide sales tax, although Alaska and Montana both allow local sales taxes. Delaware also imposes a gross receipts tax on businesses. Some other states have not taxes on food and other items.
        """
        return textView
    }()
    
    private let thirdQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is it regressive?"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let thirdQuestionTextView: UITextView = {
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
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        Yes, sales taxes are regressive. They are charged as a percentage of the sale price, and therefore are the same regardless of your income. This means that a poorer person pays a larger percent of their income.
        """
        return textView
    }()
    
    private let fourthQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is my business required to collect it?"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let fourthQuestionTextView: UITextView = {
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
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        If you’re selling tangible goods that are not exempt from sales tax (such as groceries), you more than likely have to collect sales tax. If you’re selling a service, such as house cleaning or legal work, that will depend on your state’s specific laws.\n
        If you’re selling goods online, you are typically required to collect sales tax from wherever your business is located.
        """
        return textView
    }()
    
    private let fifthQuestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What happens if I don't collect it?"
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let fifthQuestionTextView: UITextView = {
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
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        textView.text = """
        If you were supposed to collect sales tax and didn’t, you could be looking at high financial penalties and interest. Those rates will depend on your state. You could also potentially face criminal charges or lose your vendor license.
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
private extension FAQViewController {
    
    func initialSetup() {
        configureUI()
        configureNavigationBar()
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray6

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(firstQuestionLabel)
        contentView.addSubview(firstQuestionTextView)
        contentView.addSubview(secondQuestionLabel)
        contentView.addSubview(secondQuestionTextView)
        contentView.addSubview(thirdQuestionLabel)
        contentView.addSubview(thirdQuestionTextView)
        contentView.addSubview(fourthQuestionLabel)
        contentView.addSubview(fourthQuestionTextView)
        contentView.addSubview(fifthQuestionLabel)
        contentView.addSubview(fifthQuestionTextView)
        
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
        
        let firstQuestionLabelConstraints = [
            firstQuestionLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            firstQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let firstQuestionTextViewConstraints = [
            firstQuestionTextView.topAnchor.constraint(equalTo: firstQuestionLabel.bottomAnchor, constant: 8),
            firstQuestionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            firstQuestionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let secondQuestionLabelConstraints = [
            secondQuestionLabel.topAnchor.constraint(equalTo: firstQuestionTextView.bottomAnchor, constant: 24),
            secondQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let secondQuestionTextViewConstraints = [
            secondQuestionTextView.topAnchor.constraint(equalTo: secondQuestionLabel.bottomAnchor, constant: 8),
            secondQuestionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            secondQuestionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let thirdQuestionLabelConstraints = [
            thirdQuestionLabel.topAnchor.constraint(equalTo: secondQuestionTextView.bottomAnchor, constant: 24),
            thirdQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let thirdQuestionTextViewConstraints = [
            thirdQuestionTextView.topAnchor.constraint(equalTo: thirdQuestionLabel.bottomAnchor, constant: 8),
            thirdQuestionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thirdQuestionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let fourthQuestionLabelConstraints = [
            fourthQuestionLabel.topAnchor.constraint(equalTo: thirdQuestionTextView.bottomAnchor, constant: 24),
            fourthQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fourthQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let fourthQuestionTextViewConstraints = [
            fourthQuestionTextView.topAnchor.constraint(equalTo: fourthQuestionLabel.bottomAnchor, constant: 8),
            fourthQuestionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fourthQuestionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let fifthQuestionLabelConstraints = [
            fifthQuestionLabel.topAnchor.constraint(equalTo: fourthQuestionTextView.bottomAnchor, constant: 24),
            fifthQuestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fifthQuestionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let fifthQuestionTextViewConstraints = [
            fifthQuestionTextView.topAnchor.constraint(equalTo: fifthQuestionLabel.bottomAnchor, constant: 8),
            fifthQuestionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fifthQuestionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            fifthQuestionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        
        NSLayoutConstraint.activate(firstQuestionLabelConstraints)
        NSLayoutConstraint.activate(firstQuestionTextViewConstraints)
        
        NSLayoutConstraint.activate(secondQuestionLabelConstraints)
        NSLayoutConstraint.activate(secondQuestionTextViewConstraints)
        
        NSLayoutConstraint.activate(thirdQuestionLabelConstraints)
        NSLayoutConstraint.activate(thirdQuestionTextViewConstraints)
        
        NSLayoutConstraint.activate(fourthQuestionLabelConstraints)
        NSLayoutConstraint.activate(fourthQuestionTextViewConstraints)
        
        NSLayoutConstraint.activate(fifthQuestionLabelConstraints)
        NSLayoutConstraint.activate(fifthQuestionTextViewConstraints)
        
        scrollView.contentSize = contentView.bounds.size
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = DARK_APPEARANCE
            firstQuestionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
            secondQuestionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
            thirdQuestionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
            fourthQuestionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
            fifthQuestionTextView.backgroundColor = #colorLiteral(red: 0.2433706357, green: 0.2505630392, blue: 0.2873807403, alpha: 1)
        } else {
            view.backgroundColor = LIGHT_APPEARANCE
            
        }
    }
    
    func configureNavigationBar() {
        title = "FAQs"
        
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

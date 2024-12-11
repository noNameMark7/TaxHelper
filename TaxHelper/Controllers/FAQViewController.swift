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
    
    private let howToCalculateItLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.howToCalculateItLabel.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let howToCalculateItTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.howToCalculateItTextView.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return textView
    }()
    
    private let whatStatesDonotHaveItLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.whatStatesDonotHaveItLabel.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let whatStatesDonotHaveItTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.whatStatesDonotHaveItTextView.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return textView
    }()
    
    private let isItRegressiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.isItRegressiveLabel.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let isItRegressiveTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.isItRegressiveTextView.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return textView
    }()
    
    private let isMyBusinessRequiredToCollectItLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.isMyBusinessRequiredToCollectIt.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let isMyBusinessRequiredToCollectItTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.isMyBusinessRequiredToCollectItTextView.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return textView
    }()
    
    private let whatHappensIfIDonotCollectItLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = TextValues.whatHappensIfIDonotCollectIt.rawValue
        label.font = FontManager.shared.labelFont(withSize: 19, withWeight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let whatHappensIfIDonotCollectItTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = TextValues.whatHappensIfIDonotCollectItTextView.rawValue
        textView.font = FontManager.shared.labelFont(withSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textAlignment = .left
        textView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
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
private extension FAQViewController {
    
    func setupUI() {
        setupConstraints()
        configureNavigationBar()
    }
    
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let components = [
            howToCalculateItLabel,
            howToCalculateItTextView,
            whatStatesDonotHaveItLabel,
            whatStatesDonotHaveItTextView,
            isItRegressiveLabel,
            isItRegressiveTextView,
            isMyBusinessRequiredToCollectItLabel,
            isMyBusinessRequiredToCollectItTextView,
            whatHappensIfIDonotCollectItLabel,
            whatHappensIfIDonotCollectItTextView
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
        
        let firstQuestionLabelConstraints = [
            howToCalculateItLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            howToCalculateItLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            howToCalculateItLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let firstQuestionTextViewConstraints = [
            howToCalculateItTextView.topAnchor.constraint(equalTo: howToCalculateItLabel.bottomAnchor, constant: 8),
            howToCalculateItTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            howToCalculateItTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let secondQuestionLabelConstraints = [
            whatStatesDonotHaveItLabel.topAnchor.constraint(equalTo: howToCalculateItTextView.bottomAnchor, constant: 24),
            whatStatesDonotHaveItLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whatStatesDonotHaveItLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let secondQuestionTextViewConstraints = [
            whatStatesDonotHaveItTextView.topAnchor.constraint(equalTo: whatStatesDonotHaveItLabel.bottomAnchor, constant: 8),
            whatStatesDonotHaveItTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            whatStatesDonotHaveItTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let thirdQuestionLabelConstraints = [
            isItRegressiveLabel.topAnchor.constraint(equalTo: whatStatesDonotHaveItTextView.bottomAnchor, constant: 24),
            isItRegressiveLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let thirdQuestionTextViewConstraints = [
            isItRegressiveTextView.topAnchor.constraint(equalTo: isItRegressiveLabel.bottomAnchor, constant: 8),
            isItRegressiveTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            isItRegressiveTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let fourthQuestionLabelConstraints = [
            isMyBusinessRequiredToCollectItLabel.topAnchor.constraint(equalTo: isItRegressiveTextView.bottomAnchor, constant: 24),
            isMyBusinessRequiredToCollectItLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            isMyBusinessRequiredToCollectItLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let fourthQuestionTextViewConstraints = [
            isMyBusinessRequiredToCollectItTextView.topAnchor.constraint(equalTo: isMyBusinessRequiredToCollectItLabel.bottomAnchor, constant: 8),
            isMyBusinessRequiredToCollectItTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            isMyBusinessRequiredToCollectItTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let fifthQuestionLabelConstraints = [
            whatHappensIfIDonotCollectItLabel.topAnchor.constraint(equalTo: isMyBusinessRequiredToCollectItTextView.bottomAnchor, constant: 24),
            whatHappensIfIDonotCollectItLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whatHappensIfIDonotCollectItLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let fifthQuestionTextViewConstraints = [
            whatHappensIfIDonotCollectItTextView.topAnchor.constraint(equalTo: whatHappensIfIDonotCollectItLabel.bottomAnchor, constant: 8),
            whatHappensIfIDonotCollectItTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            whatHappensIfIDonotCollectItTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            whatHappensIfIDonotCollectItTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
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
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
            [
                howToCalculateItTextView,
                whatStatesDonotHaveItTextView,
                isItRegressiveTextView,
                isMyBusinessRequiredToCollectItTextView,
                whatHappensIfIDonotCollectItTextView
            ].forEach { component in
                component.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            }
        } else {
            view.backgroundColor = .white
            [
                howToCalculateItTextView,
                whatStatesDonotHaveItTextView,
                isItRegressiveTextView,
                isMyBusinessRequiredToCollectItTextView,
                whatHappensIfIDonotCollectItTextView
            ].forEach { component in
                component.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
        }
    }
}

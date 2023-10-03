import UIKit

class CreateAccountDetailViewController: UIViewController {

    // MARK: - Properties

    private let notificationCenter = NotificationCenter.default

    // MARK: - UI Elements

    private lazy var createAccountDetailView = CreateAccountDetailView()

    private lazy var titleLabel = UILabel.makeLabel(text: "Sign Up", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)

    //почему она красная?.. 
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .done, target: self, action: #selector(backButtonAction))
        button.tintColor = .purple
        return button
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver (self, selector: #selector (keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super .touchesBegan(touches, with: event)
    }

    // MARK: - Methods

    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = backButton
    }

    private func layout() {

        let screenWidth = UIScreen.main.bounds.width

        view.addSubview(scrollView)
        scrollView.addSubview(createAccountDetailView)

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            createAccountDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            createAccountDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            createAccountDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            createAccountDetailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            createAccountDetailView.heightAnchor.constraint(equalToConstant: 800),
            createAccountDetailView.widthAnchor.constraint(equalToConstant: screenWidth)
        ])
    }

    @objc private func backButtonAction() {
        print("back button tapped")
    }

    @objc
    private func keyboardShow(notification: NSNotification) {
        if let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height + 130
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: keyboardSize.height,
                                                                    right: 0)
        }
    }

    @objc
    private func keyboardHide() {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

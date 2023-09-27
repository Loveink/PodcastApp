import UIKit

class CreateAccountDetailViewController: UIViewController {

    // MARK: - Properties

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
            createAccountDetailView.heightAnchor.constraint(equalToConstant: 1000),
            createAccountDetailView.widthAnchor.constraint(equalToConstant: screenWidth)
        ])
    }

    @objc private func backButtonAction() {
        print("back button tapped")
    }
}

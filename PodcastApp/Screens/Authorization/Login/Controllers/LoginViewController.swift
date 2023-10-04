import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties

    let loginView = LoginView()

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
      loginView.navigationController = navigationController
    }

    // MARK: - Methods

    private func layout() {

        view.addSubview(loginView)

        NSLayoutConstraint.activate([

            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

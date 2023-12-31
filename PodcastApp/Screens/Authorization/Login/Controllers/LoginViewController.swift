import UIKit
import Firebase
import GoogleSignIn

// почему не пушится экран при успешной авторизации через гугл?

class LoginViewController: UIViewController {

    // MARK: - Properties

    let loginView = LoginView()

    // MARK: - UI Elements

    private lazy var googleButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Continue with Google", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.manropeBold(size: 16)
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 28
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(googleButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        loginView.navigationController = navigationController
        navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView?.isHidden = true
        self.navigationItem.largeTitleDisplayMode = .never
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    // MARK: - Methods

    private func layout() {

        view.addSubview(loginView)
        view.addSubview(googleButton)

        NSLayoutConstraint.activate([

            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            googleButton.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: 650),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 57)
        ])
    }

    @objc private func googleButtonAction() {
        print ("google button tapped")

        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                print ("Error by authorization: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            print (credential, user.userID as Any, user.idToken as Any, "авторизация успешна")

            if let tabbar = self.tabBarController {
                navigationController?.pushViewController(tabbar, animated: true)
            }
        }
    }
}



import UIKit
import Firebase
import GoogleSignIn

class CreateAccountViewController: UIViewController {

    // MARK: - UI Elements
    
    private lazy var createAccountView = CreateAccountView()

    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .done, target: self, action: #selector(backButtonAction))
        button.tintColor = .purple
        return button
    }()

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
        createAccountView.navigationController = navigationController
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Methods

    private func layout() {

        view.addSubview(createAccountView)
        createAccountView.addSubview(googleButton)

        NSLayoutConstraint.activate([

            createAccountView.topAnchor.constraint(equalTo: view.topAnchor),
            createAccountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createAccountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createAccountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            googleButton.bottomAnchor.constraint(equalTo: createAccountView.topAnchor, constant: 560),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleButton.heightAnchor.constraint(equalToConstant: 57)

        ])
    }

    //MARK: - Selectors

    @objc private func backButtonAction() {
        print("back button tapped")
        self.navigationController?.popViewController(animated: true)
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

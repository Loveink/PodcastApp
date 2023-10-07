import Foundation
import UIKit
import Firebase
import FirebaseAuth


//добавить распознаватель тапа на лейбл внизу
//добавить вход через google
// почему кнопка гугла уезжает вверх, если повторно зайти на экран? например кликнуть "назад" с домашней страницы

class LoginView: UIView {

  var navigationController: UINavigationController?

    // MARK: - UI Elements

    private lazy var loginField = UITextField.makeTextfield(text: "login@gmail.com", textColor: UIColor.textDarkgray2, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var passwordField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textDarkgray2, backgroundColor: UIColor.textfieldGray, security: true, securityButton: true)

    private lazy var loginLabel = UILabel.makeLabel(text: "Login", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var passwordLabel = UILabel.makeLabel(text: "Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var loginButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Log In", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.manropeBold(size: 16)
        $0.backgroundColor = UIColor.bluePlayer
        $0.layer.cornerRadius = 28
        $0.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var continueLabel = UILabel.makeLabel(text: "Or continue with", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textDarkgray)

    private lazy var signUpView: UITextView = {

        let attributedString = NSMutableAttributedString (string: "Don't have an account yet? Sign up")
        attributedString.addAttribute(.link, value: "signUp://signUp", range: (attributedString.string as NSString).range(of: "Sign up"))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attributedString.length))
        

        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemGreen]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = UIColor.textDarkgray
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.delaysContentTouches = false
        return tv
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let labelCenterX = continueLabel.center.x
        let labelCenterY = continueLabel.center.y

        let leftLine = UIBezierPath()
        leftLine.move(to: CGPoint (x: labelCenterX - 130, y: labelCenterY))
        leftLine.addLine(to: CGPoint(x: labelCenterX - 70, y: labelCenterY))
        UIColor.darkGray.setStroke()
        leftLine.lineWidth = 1.0
        leftLine.stroke()

        let rightLine = UIBezierPath()
        rightLine.move(to: CGPoint (x: labelCenterX + 70, y: labelCenterY))
        rightLine.addLine(to: CGPoint (x: labelCenterX + 130, y: labelCenterY))
        UIColor.darkGray.setStroke()
        rightLine.lineWidth = 1.0
        rightLine.stroke()
    }

    private func layout() {

        [loginField, loginLabel, passwordLabel, passwordField, loginButton, continueLabel, signUpView].forEach { self.addSubview($0) }

        let updownInset: CGFloat = 12
        let sideInset: CGFloat = 20

        NSLayoutConstraint.activate([

            loginField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            loginField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            loginField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            loginField.heightAnchor.constraint(equalToConstant: 45),

            loginLabel.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -updownInset/2),
            loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            passwordLabel.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: updownInset),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: updownInset/2),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            passwordField.heightAnchor.constraint(equalToConstant: 45),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: updownInset*2),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            loginButton.heightAnchor.constraint(equalToConstant: 57),

            continueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            continueLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: updownInset*4),

            signUpView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }

    //MARK: - Selectors

    @objc private func loginButtonAction(_ sender: UIButton) {

        if let email = loginField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print("Ошибка входа: \(error.localizedDescription)")
                    self.alertMessage()
                } else {
                    if let user = user {
                        print("Пользователь авторизован: \(user)")
                      let tabbar = CustomTabBar()
                      self.navigationController?.pushViewController(tabbar, animated: true)
                    }
                }
            }
        }

// получить доступ к данным текущего пользователя
//        if let user = Auth.auth().currentUser {
//            let uid = user.uid
//            let email = user.email
//            print (uid, email ?? "no email")
//        }
    }

    @objc private func alertMessage() {

        let alertMessage = UIAlertController(title: "Error", message: "Incorrect email and/or passwort", preferredStyle: .alert)

        let okButton = UIAlertAction (title: "Ok", style: .default, handler: { (action) -> Void in print ("Ok button tapped")
        })

        alertMessage.addAction(okButton)
        if let viewController = self.closestViewController() {
                viewController.present(alertMessage, animated: true, completion: nil)
            }
    }
}

    //MARK: - Extensions

extension UIView {
    func closestViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let viewController = currentResponder as? UIViewController {
                return viewController
            }
            responder = currentResponder.next
        }
        return nil
    }
}

extension LoginView: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if URL.scheme == "signUp" {
            let createAccountVC = CreateAccountViewController()
            self.navigationController?.pushViewController(createAccountVC, animated: true)
        }
        return true
    }
}

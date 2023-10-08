import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

// добавить сокрытие клавиатуры по тапу где-нибудь (на кнопку return например)
// добавить распознаватель тапа для текста внизу
// отрефакторить отображение ошибок. Сейчас ошибки выпадают в том порядке, в котором возникают. Лучше: все ошибки показываются на экране одновременно

class CreateAccountDetailView: UIView {

    // MARK: - Properties

    var navigationController: UINavigationController?

    // MARK: - UI Elements

    private lazy var headLabel = UILabel.makeLabel(text: "Complete your account", font: UIFont.plusJakartaSansBold(size: 24), textColor: UIColor.black)

    // поля для textField
    private lazy var firstnameField = UITextField.makeTextfield(text: "Enter your first name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var lastnameField = UITextField.makeTextfield(text: "Enter your last name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var emailField = UITextField.makeTextfield(text: "Enter your email", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var passwordField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

    private lazy var confirmField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

    // лейблы к каждому textField
    private lazy var firstnameLabel = UILabel.makeLabel(text: "First Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var lastnameLabel = UILabel.makeLabel(text: "Last Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var emailLabel = UILabel.makeLabel(text: "Email", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var passwordLabel = UILabel.makeLabel(text: "Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var confirmLabel = UILabel.makeLabel(text: "Confirm Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var errorLabel = UILabel.makeLabel(text: "All fields must be filled in", font: UIFont.sfProRegular(size: 7), textColor: UIColor.systemRed)

    private lazy var emailForm = UILabel.makeLabel(text: "Email must be in @-format", font: UIFont.boldSystemFont(ofSize: 10), textColor: UIColor.systemRed)

    private lazy var passwordMatch = UILabel.makeLabel(text: "Password do not match", font: UIFont.boldSystemFont(ofSize: 10), textColor: UIColor.systemRed)

    private lazy var passwordLength = UILabel.makeLabel(text: "Password must be at least 6 characters long", font: UIFont.boldSystemFont(ofSize: 10), textColor: UIColor.systemRed)

    private lazy var signupButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Sign Up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.manropeBold(size: 16)
        $0.backgroundColor = UIColor.bluePlayer
        $0.layer.cornerRadius = 28
        $0.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())

//    private lazy var loginLabel = UILabel.makeLabel(text: "Already have an account? Login", font: UIFont.plusJakartaSansSemiBold(size: 16), textColor: UIColor.darkGray)

    private lazy var loginLabel: UITextView = {

        let attributedString = NSMutableAttributedString (string: "Already have an account? Login")
        attributedString.addAttribute(.link, value: "login://login", range: (attributedString.string as NSString).range(of: "Login"))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: attributedString.length))


        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
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
        self.translatesAutoresizingMaskIntoConstraints = false
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func layout() {

        [headLabel, firstnameField, lastnameField, emailField, passwordField, confirmField, firstnameLabel, lastnameLabel, emailLabel, passwordLabel, confirmLabel, signupButton, loginLabel, errorLabel, passwordMatch, emailForm, passwordLength].forEach { self.addSubview($0) }

        errorLabel.isHidden = true
        passwordMatch.isHidden = true
        emailForm.isHidden = true
        passwordLength.isHidden = true

        let sideInset: CGFloat = 24
        let updownInset: CGFloat = 8

        NSLayoutConstraint.activate([

            headLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            headLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            signupButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: 60),
            signupButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            signupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            signupButton.heightAnchor.constraint(equalToConstant: 57),

            errorLabel.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -updownInset),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            loginLabel.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 24),
            loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            //констрейнты для поля имени
            firstnameLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 62),
            firstnameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            firstnameField.topAnchor.constraint(equalTo: firstnameLabel.bottomAnchor, constant: updownInset),
            firstnameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            firstnameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            firstnameField.heightAnchor.constraint(equalToConstant: 45),

            //констрейнты для поля фамилии
            lastnameLabel.topAnchor.constraint(equalTo: firstnameField.bottomAnchor, constant: 12),
            lastnameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            lastnameField.topAnchor.constraint(equalTo: lastnameLabel.bottomAnchor, constant: updownInset),
            lastnameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            lastnameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            lastnameField.heightAnchor.constraint(equalToConstant: 45),

            //констрейнты для поля имейла
            emailLabel.topAnchor.constraint(equalTo: lastnameField.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: updownInset),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            emailField.heightAnchor.constraint(equalToConstant: 45),

            emailForm.centerYAnchor.constraint(equalTo: emailLabel.centerYAnchor),
            emailForm.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),

            //констрейнты для поля пароля
            passwordLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: updownInset),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            passwordField.heightAnchor.constraint(equalToConstant: 45),

            passwordLength.centerYAnchor.constraint(equalTo: passwordLabel.centerYAnchor),
            passwordLength.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),

            //констрейнты для подтверждения пароля
            confirmLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            confirmLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            confirmField.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: updownInset),
            confirmField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            confirmField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            confirmField.heightAnchor.constraint(equalToConstant: 45),

            passwordMatch.centerYAnchor.constraint(equalTo: confirmLabel.centerYAnchor),
            passwordMatch.trailingAnchor.constraint(equalTo: confirmField.trailingAnchor),
        ])
    }

    private func wrongTextField(_ textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }

    // MARK: - Selectors

    @objc private func signupButtonAction(_ sender: UIButton) {

        errorLabel.isHidden = true
        passwordMatch.isHidden = true
        emailForm.isHidden = true
        passwordLength.isHidden = true

        var fieldsArray: [UITextField] = []

        fieldsArray.append(firstnameField)
        fieldsArray.append(lastnameField)
        fieldsArray.append(emailField)
        fieldsArray.append(passwordField)
        fieldsArray.append(confirmField)

        guard let firstName = firstnameField.text, !firstName.isEmpty,
              let lastName = lastnameField.text, !lastName.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let confirmPassword = confirmField.text, !confirmPassword.isEmpty
        else {
            print ("One or many fields aren't filled in")
            fieldsArray.forEach {
                if $0.text == "" {
                    wrongTextField($0)
                    errorLabel.isHidden = false
                }
            }
            return
        }

        guard password == confirmPassword
        else {
            print ("Passwords do not match")
            wrongTextField(passwordField)
            wrongTextField(confirmField)
            passwordMatch.isHidden = false
            return
        }

        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) {
            (authResult, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                if error.localizedDescription == "The email address is badly formatted." {
                    self.wrongTextField(self.emailField)
                    self.emailForm.isHidden = false
                } else if error.localizedDescription == "The password must be 6 characters long or more." {
                    self.wrongTextField(self.passwordField)
                    self.passwordLength.isHidden = false
                }
            } else {
                //регистрация прошла успешно
                print ("User \(authResult?.user.email as Any) has been successfully registered")

                if let userID = authResult?.user.uid {
                    let db = Firestore.firestore()
                    let userRef = db.collection("users").document(userID)

                    let userData = [
                        "email": email,
                        "firstName": firstName,
                        "lastName": lastName
                    ]

                    userRef.setData(userData) { error in
                        if let error = error {
                            print ("Error when saving user data")
                        } else {
                            print ("User data has been saved in Firestore")
                        }
                    }
                }

                print ("Push home screen")
                let tabbar = CustomTabBar()
                self.navigationController?.pushViewController(tabbar, animated: true)

            }
        }
    }
}

//MARK: - Extensions

extension CreateAccountDetailView: UITextViewDelegate {

func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

    if URL.scheme == "login" {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    return true
}
}

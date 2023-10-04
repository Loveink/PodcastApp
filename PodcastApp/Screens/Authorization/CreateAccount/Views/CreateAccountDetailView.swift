import Foundation
import UIKit
import FirebaseAuth

// добавить сокрытие клавиатуры по тапу где-нибудь (на кнопку return например)
// добавить распознаватель тапа для текста внизу
// !!! решить вопрос с имейлом: либо тянуть с прошлого экрана, либо удалять тот экран и добавлять сюда новое текстовое поле
// добавить проверки и условия текстовых полей, чтобы вводились корректные данные

class CreateAccountDetailView: UIView {
  var navigationController: UINavigationController?
  // MARK: - UI Elements

  private lazy var headLabel = UILabel.makeLabel(text: "Complete your account", font: UIFont.plusJakartaSansBold(size: 24), textColor: UIColor.black)

  // поля для textField
  private lazy var firstnameField = UITextField.makeTextfield(text: "Enter your first name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

  private lazy var lastnameField = UITextField.makeTextfield(text: "Enter your last name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

  private lazy var passwordField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

  private lazy var confirmField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

  // лейблы к каждому textField
  private lazy var firstnameLabel = UILabel.makeLabel(text: "First Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

  private lazy var lastnameLabel = UILabel.makeLabel(text: "Last Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

  private lazy var passwordLabel = UILabel.makeLabel(text: "Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

  private lazy var confirmLabel = UILabel.makeLabel(text: "Confirm Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

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

  private lazy var loginLabel = UILabel.makeLabel(text: "Already have an account? Login", font: UIFont.plusJakartaSansSemiBold(size: 16), textColor: UIColor.darkGray)

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

    [headLabel, firstnameField, lastnameField, passwordField, confirmField, firstnameLabel, lastnameLabel, passwordLabel, confirmLabel, signupButton, loginLabel].forEach { self.addSubview($0) }

    let sideInset: CGFloat = 24
    let updownInset: CGFloat = 8

    NSLayoutConstraint.activate([

      headLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
      headLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      signupButton.topAnchor.constraint(equalTo: confirmField.bottomAnchor, constant: 50),
      signupButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
      signupButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
      signupButton.heightAnchor.constraint(equalToConstant: 57),

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

      //констрейнты для поля пароля
      passwordLabel.topAnchor.constraint(equalTo: lastnameField.bottomAnchor, constant: 12),
      passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

      passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: updownInset),
      passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
      passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
      passwordField.heightAnchor.constraint(equalToConstant: 45),

      //констрейнты для подтверждения пароля
      confirmLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
      confirmLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

      confirmField.topAnchor.constraint(equalTo: confirmLabel.bottomAnchor, constant: updownInset),
      confirmField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
      confirmField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
      confirmField.heightAnchor.constraint(equalToConstant: 45),
    ])
  }

    @objc private func signupButtonAction(_ sender: UIButton) {

        // в качестве логина временно принимается текст из firstnameField. Логин нужно указывать с доменом @
        //уже зарегистрированы пользователи doctor@gmail.com и doctor1@gmail.com с одинаковыми паролями 123456
        Auth.auth().createUser(withEmail: firstnameField.text!, password: passwordField.text!) { (authResult, error) in
            if let error = error {
                print("Ошибка регистрации: \(error.localizedDescription)")
            } else {
                print ("Успешно зарегистрирован пользователь \(authResult?.user.email as Any)")
            }
          let tabbar = CustomTabBar()
          self.navigationController?.pushViewController(tabbar, animated: true)
        }

//        var responder: UIResponder? = signupButton
//        while let nextResponder = responder?.next {
//            if let viewController = nextResponder as? UIViewController {
//                let tabbar = CustomTabBar()
//                tabbar.modalPresentationStyle = .fullScreen
//                viewController.present(tabbar, animated: true, completion: nil)
//                break
//            }
//            responder = nextResponder
//        }
    }

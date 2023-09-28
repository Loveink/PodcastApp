import Foundation
import UIKit

// добавить сокрытие клавиатуры по тапу где-нибудь (на кнопку return например)

class CreateAccountDetailView: UIView {

    // MARK: - UI Elements

    private lazy var headLabel = UILabel.makeLabel(text: "Complete your account", font: UIFont.plusJakartaSansBold(size: 24), textColor: UIColor.black)

    // поля для textField
    private lazy var firstnameField = UITextField.makeTextfield(text: "Enter your first name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var lastnameField = UITextField.makeTextfield(text: "Enter your last name", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var passwordField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

    private lazy var confirmField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: true)

//    private lazy var passwordField: UITextField = {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.size.height))
//        let eyeButton = UIButton(frame: CGRect (x: 0, y: 0, width: 30, height: 30))
//        eyeButton.setImage(UIImage (named: "eyeOpen"), for: .normal)
//        eyeButton.setImage(UIImage (named: "eyeClosed"), for: .selected)
//        eyeButton.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = UIColor.textfieldGray
//        $0.layer.cornerRadius = 10
//        $0.layer.borderWidth = 0.5
//        $0.layer.borderColor = UIColor.borderGray.cgColor
//        $0.placeholder = "••••••"
//        $0.leftView = paddingView
//        $0.rightView = eyeButton
//        $0.leftViewMode = .always
//        $0.rightViewMode = .always
//        $0.isSecureTextEntry = true
//        return $0
//    }(UITextField())

    // лейблы к каждому textField
    private lazy var firstnameLabel = UILabel.makeLabel(text: "First Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var lastnameLabel = UILabel.makeLabel(text: "Last Name", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var passwordLabel = UILabel.makeLabel(text: "Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var confirmLabel = UILabel.makeLabel(text: "Confirm Password", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var signupButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Sign Up", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.plusJakartaSansBold(size: 16)
        $0.backgroundColor = UIColor.bluePlayer
        $0.layer.cornerRadius = 28
        $0.addTarget(self, action: #selector(signupButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var loginLabel = UILabel.makeLabel(text: "Already have an account? Login", font: UIFont.plusJakartaSansBold(size: 16), textColor: UIColor.darkGray)

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

    @objc private func signupButtonAction() {
        print ("sign up button tapped")
    }

//    @objc private func eyeButtonAction() {
//        passwordField.isSecureTextEntry.toggle()
//        passwordField.rightView?.isSelected.toggle()
//    }
}

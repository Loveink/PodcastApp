import Foundation
import UIKit


//добавить распознаватель тапа на лейбл внизу
//добавить вход через google

class LoginView: UIView {
  var navigationController: UINavigationController?

    // MARK: - UI Elements

    private lazy var loginField = UITextField.makeTextfield(text: "login@gmail.com", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var passwordField = UITextField.makeTextfield(text: "••••••", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: true, securityButton: true)

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

    private lazy var signupLabel = UILabel.makeLabel(text: "Don't have an account yet? Sign up", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textDarkgray)

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

        [loginField, loginLabel, passwordLabel, passwordField, loginButton, continueLabel, signupLabel].forEach { self.addSubview($0) }

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

            signupLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signupLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }

  @objc private func loginButtonAction(_ sender: UIButton) {
    let createAccountVC = CreateAccountViewController()
    self.navigationController?.pushViewController(createAccountVC, animated: true)
  }
}

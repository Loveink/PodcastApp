import Foundation
import UIKit

//дорисовать линии к continue with
// добавить кнопку входа по google
//добавить распознаватель тапа

class CreateAccountView: UIView {

  var navigationController: UINavigationController?

    // MARK: - UI Elements

    private lazy var headLabel = UILabel.makeLabel(text: "Create account", font: UIFont.plusJakartaSansBold(size: 24), textColor: UIColor.white)

    private lazy var backgroundView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .white
        return $0
    }(UIImageView())

    private lazy var emailLabel = UILabel.makeLabel(text: "Email", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textGrey)

    private lazy var emailField = UITextField.makeTextfield(text: "Enter your email address", textColor: UIColor.textGrey, backgroundColor: UIColor.textfieldGray, security: false, securityButton: false)

    private lazy var continueButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Continue with Email", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.manropeBold(size: 16)
        $0.backgroundColor = UIColor.bluePlayer
        $0.layer.cornerRadius = 28
        $0.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var continueLabel = UILabel.makeLabel(text: "Or continue with", font: UIFont.sfProRegular(size: 14), textColor: UIColor.textDarkgray)

//    lazy var loginLabel = UILabel.makeLabel(text: "Already have an account? Login", font: UIFont.plusJakartaSansSemiBold(size: 16), textColor: UIColor.darkGray)

    private lazy var backToLoginView: UITextView = {

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
        self.backgroundColor = UIColor.bluePlayer
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

        [headLabel, backgroundView, emailLabel, emailField, continueButton, continueLabel, backToLoginView].forEach { self.addSubview($0) }

        let sideInset: CGFloat = 24
        let updownInset: CGFloat = 8

        NSLayoutConstraint.activate([

            headLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            headLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            backgroundView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 80),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            emailLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 47),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),

            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: updownInset),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            emailField.heightAnchor.constraint(equalToConstant: 45),

            continueButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: updownInset*4),
            continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: sideInset),
            continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -sideInset),
            continueButton.heightAnchor.constraint(equalToConstant: 57),

            continueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            continueLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: updownInset*4),

            backToLoginView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backToLoginView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
            ])
    }

    //MARK: - Selectors

  @objc private func continueButtonAction(_ sender: UIButton) {
    let createAccountDetailVC = CreateAccountDetailViewController()
    self.navigationController?.pushViewController(createAccountDetailVC, animated: true)
  }
}

    //MARK: - Extensions

extension CreateAccountView: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if URL.scheme == "login" {
            self.navigationController?.popViewController(animated: true)
        }
        return true
    }
}

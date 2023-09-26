import UIKit

extension UITextField {

    static func makeTextfield(text: String = "", textColor: UIColor, backgroundColor: UIColor, security: Bool) -> UITextField {

        let field = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.size.height))

        field.placeholder = text
        field.textColor = textColor
        field.backgroundColor = backgroundColor
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.borderGray.cgColor
        field.leftView = paddingView
        field.leftViewMode = .always
        field.isSecureTextEntry = security
        field.clearButtonMode = .whileEditing
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}

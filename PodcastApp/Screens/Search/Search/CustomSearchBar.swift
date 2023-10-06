//
//  CustomSearchBar.swift
//  PodcastApp
//
//  Created by Владимир on 25.09.2023.
//

import UIKit

class CustomSearchBar: UIView {

    let textField = UITextField()
    private let searchButton = UIButton()
    private let crossButton = UIButton()
    
    var delegate: SearchViewControllerDelegate?
    
    
    
    init() {
        super.init(frame: .null)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        searchButton.addTarget(target, action: action, for: controlEvents)
    }
    
    
    func setCloseSquare() {
        crossButton.isHidden = false
        searchButton.isHidden = true
        textField.rightView = crossButton
    }
    
    @objc private func clearTextField() {
        textField.text = ""
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
    
    
    private func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .gray
        
        crossButton.isHidden = true
        crossButton.tintColor = .gray
        crossButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        crossButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        let placeholder = NSAttributedString(string: "Podcast, channel, or artists", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.manropeBold(size: 18)!])
        textField.attributedPlaceholder = placeholder
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = .manropeRegular(size: 18)
        textField.textColor = .black
        textField.rightView = searchButton
        textField.rightViewMode = .always
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func setupConstraints() {
        self.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}




extension CustomSearchBar: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.startTyping()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButton.sendActions(for: .touchUpInside)
        return true
    }
    
}

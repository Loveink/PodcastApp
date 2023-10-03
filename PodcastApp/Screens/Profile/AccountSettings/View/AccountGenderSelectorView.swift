//
//  AccountGenderSelectorView.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 01.10.2023.
//

import UIKit

class AccountGenderSelectorView: UIView {
    
    //MARK: - UI Componets
    
    private lazy var genderLabel = UILabel.makeLabel(text: "Gender", font: UIFont.plusJakartaSansMedium(size: 14), textColor: UIColor.textGrey)
    
    private var maleButton = AccountGenderButton(withStyle: .male, isOn: true)
    private var femaleButton = AccountGenderButton(withStyle: .female)
    
    private let genderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Unit
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConsrtaints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        addSubview(genderLabel)
        addSubview(genderStack)
        genderStack.addArrangedSubview(maleButton)
        genderStack.addArrangedSubview(femaleButton)
    }
    
    private func setupConsrtaints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: self.topAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            genderStack.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            genderStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            genderStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            genderStack.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    //MARK: - Methods
    
    @objc private func maleButtonPressed() {
        maleButton.setupCheck(status: true)
        femaleButton.setupCheck(status: false)
    }
    
    @objc private func femaleButtonPressed() {
        maleButton.setupCheck(status: false)
        femaleButton.setupCheck(status: true)
    }
    
    private func configure() {
        maleButton.addTarget(self, action: #selector(maleButtonPressed), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleButtonPressed), for: .touchUpInside)
    }
}

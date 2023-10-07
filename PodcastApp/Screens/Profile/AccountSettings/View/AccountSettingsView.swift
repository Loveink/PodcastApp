//
//  AccountSettingsView.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 28.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountSettingsView: UIView {

    //MARK: - UI Components
    
    private lazy var firstNameField = UITextField.makeBlueTextField(text: "")
    
    private lazy var lastNameField = UITextField.makeBlueTextField(text: "")
    
    private lazy var emailField = UITextField.makeBlueTextField(text: "")
    
    private lazy var birthdayField = UITextField.makeBlueTextField(text: "")
    
    private lazy var maleField = UITextField.makeBlueTextField(text: "Male")
    
    private lazy var femaleField = UITextField.makeBlueTextField(text: "Female")
    
    private lazy var firstNameLabel = UILabel.makeLabel(text: "First Name", font: UIFont.plusJakartaSansMedium(size: 14), textColor: UIColor.textGrey)
    
    private lazy var lastNameLabel = UILabel.makeLabel(text: "Last Name", font: UIFont.plusJakartaSansMedium(size: 14), textColor: UIColor.textGrey)
    
    private lazy var emailLabel = UILabel.makeLabel(text: "E-mail", font: UIFont.plusJakartaSansMedium(size: 14), textColor: UIColor.textGrey)
    
    private lazy var birthdayLabel = UILabel.makeLabel(text: "Date of Birth", font: UIFont.plusJakartaSansMedium(size: 14), textColor: UIColor.textGrey)
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Calendar"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(datePickerTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        return datePicker
    }()
    
    private let genderSection = AccountGenderSelectorView()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save changes", for: .normal)
        button.setTitleColor(UIColor.textGrey, for: .normal)
        button.titleLabel?.font = UIFont.plusJakartaSansSemiBold(size: 16)
        button.backgroundColor = UIColor.grayBackground
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Unit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isHidden = true
        birthdayField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        addSubviews()
        setupConstraints()
        fetchUserData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        
        self.addSubview(firstNameField)
        self.addSubview(lastNameField)
        self.addSubview(emailField)
        self.addSubview(birthdayField)
        
        self.addSubview(firstNameLabel)
        self.addSubview(lastNameLabel)
        self.addSubview(emailLabel)
        self.addSubview(birthdayLabel)
        
        self.addSubview(genderSection)
        
        self.addSubview(saveButton)
        
        birthdayField.addSubview(calendarButton)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            firstNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            firstNameField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            firstNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            firstNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            firstNameField.heightAnchor.constraint(equalToConstant: 52),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 16),
            lastNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            lastNameField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            lastNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            lastNameField.heightAnchor.constraint(equalToConstant: 52),
            
            emailLabel.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 52),
            
            birthdayLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            birthdayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            birthdayField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            birthdayField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            birthdayField.heightAnchor.constraint(equalToConstant: 52),
            
            calendarButton.centerYAnchor.constraint(equalTo: birthdayField.centerYAnchor),
            calendarButton.trailingAnchor.constraint(equalTo: birthdayField.trailingAnchor, constant: -12),
            calendarButton.heightAnchor.constraint(equalToConstant: 24),
            calendarButton.widthAnchor.constraint(equalToConstant: 24),
            
            genderSection.topAnchor.constraint(equalTo: birthdayField.bottomAnchor, constant: 8),
            genderSection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            genderSection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34),
            saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    //MARK: - Methods

    //для проверки можно ввести данные пользователя igor@gmail.com с паролем 123456
    private func fetchUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userID)

            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data() {
                        self.firstNameField.text = data["firstName"] as? String;
                        self.lastNameField.text = data["lastName"] as? String;
                        self.emailField.text = data["email"] as? String
                    }
                } else {
                    print("Документ пользователя не найден")
                }
            }
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        birthdayField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func saveButtonTapped() {
        print ("Save button tapped")
    }
    
    @objc private func datePickerTapped() {
        datePicker.isHidden = false
    }
}

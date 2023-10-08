//
//  ProfileSettingsViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ProfileSettingsViewController: UIViewController {

  let user = Auth.auth().currentUser
  
    //MARK: - Properties
    private let rowsIconSettings: [UIImage] = [
        UIImage(systemName: "person")!,
        UIImage(systemName: "checkmark.shield")!,
        UIImage(systemName: "lock.open")!
    ]
    
    private let rowsTextSettings: [String] = [
        "Account Setting",
        "Change Password",
        "Forget Password"
    ]
    
    //MARK: - UI Components
    
    private var userNameLabel = UILabel.makeLabelForCells(text: "User Name", font: .manropeBold(size: 16), textColor: .textDarkPurple, numberOfLines: 0)
    
    private var userStatus = UILabel.makeLabelForCells(text: "love and chill", font: .manropeRegular(size: 14), textColor: .textDarkPurple, numberOfLines: 0)
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        image.isUserInteractionEnabled = true
        image.backgroundColor = .pinkBackground
        image.layer.cornerRadius = 12
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.25
        image.layer.shadowRadius = 4
        image.layer.shadowOffset = CGSize(width: 0, height: 4)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.blueBorder, for: .normal)
        button.titleLabel?.font = UIFont.plusJakartaSansMedium(size: 16)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blueBorder.cgColor
        button.layer.cornerRadius = 32
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(
            ProfileSettingsViewCell.self,
            forCellReuseIdentifier: ProfileSettingsViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addSubviews()
        setupConstraints()
        logOutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
      fetchUserData()
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(profileImage)
        view.addSubview(userNameLabel)
        view.addSubview(userStatus)
        view.addSubview(logOutButton)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            profileImage.widthAnchor.constraint(equalToConstant: 48),
            profileImage.heightAnchor.constraint(equalToConstant: 48),
            
            userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            userNameLabel.topAnchor.constraint(equalTo: profileImage.topAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            userStatus.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            userStatus.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            userStatus.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            logOutButton.heightAnchor.constraint(equalToConstant: 60),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            tableView.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -12)
        ])
    }
    
    //MARK: - Methods
    
    private func showProfileVC() {
        let vc = AccountSettingsViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func logoutButtonTapped() {
        let loginVC = LoginViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
//    @objc private func logoutButtonTapped() {
//        AuthManager.shared.logOut { [weak self] result in
//            switch result {
//            case .success(let success):
//                if success {
//                    let loginVC = LoginViewController()
//                    loginVC.modalTransitionStyle = .crossDissolve
//                    loginVC.modalPresentationStyle = .fullScreen
//                    self?.present(loginVC, animated: true)
//                }
//            case .failure(let error):
//                let alert = UIAlertController.createAlert(
//                    title: "Error", message: error.localizedDescription
//                )
//                self?.present(alert, animated: true)
//            }
//        }
//    }
  private func fetchUserData() {
      if let userID = Auth.auth().currentUser?.uid {
          let db = Firestore.firestore()
          let userRef = db.collection("users").document(userID)

          userRef.getDocument { (document, error) in
              if let document = document, document.exists {
                  if let data = document.data() {
                      self.userNameLabel.text = data["firstName"] as? String;
                  }
              } else {
                  print("Документ пользователя не найден")
              }
          }
      }
  }
}

//MARK: - Extensions

extension ProfileSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.showProfileVC()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsTextSettings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingsViewCell.identifier, for: indexPath) as? ProfileSettingsViewCell else {
            fatalError("Error")
        }
        
        let image = rowsIconSettings[indexPath.row]
        let textInRow = rowsTextSettings[indexPath.row]
        cell.configure(image: image, title: textInRow)
        let imageForCheckmark = UIImage(systemName: "chevron.right")
        let checkmark  = UIImageView(frame:CGRect(x:0, y:0, width:(imageForCheckmark?.size.width)!, height:(imageForCheckmark?.size.height)!))
        checkmark.image = imageForCheckmark
        checkmark.tintColor = .symbolsPurple
        cell.accessoryView = checkmark
        return cell
    }

}

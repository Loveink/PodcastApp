//
//  ChangePictureViewController.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 02.10.2023.
//

import UIKit

class ChangePictureViewController: UIViewController {
    
    //MARK: - UI Components
    
    private let changePicturePopUp = ChangePictureView()
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupTapGesture()
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(blurEffectView)
        view.addSubview(changePicturePopUp)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            changePicturePopUp.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            changePicturePopUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changePicturePopUp.widthAnchor.constraint(equalToConstant: 328),
            changePicturePopUp.heightAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    private func setupTapGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
        }

        @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
            dismiss(animated: true, completion: nil)
        }
}

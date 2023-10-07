//
//  ChangePictureViewController.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 02.10.2023.
//

import UIKit

class ChangePictureViewController: UIViewController {
    
    enum PicturePickerType {
        case camera
        case photoLibrary
    }
    
    //MARK: - UI Components
    
    private let changePicturePopUp = ChangePictureView()
    
   // private let blurBackgroundView = self.applyBlurEffect()
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePicturePopUp.delegate = self
        changePicturePopUp.applyBlurEffect()
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
    
    //MARK: - Methods
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChangePictureViewController: ChangePictureViewDelegate {
    func didChooseCamera() {
        presentProfilePicturePicker(type: .camera)
    } 
    
    func didChooseFromGallery() {
        presentProfilePicturePicker(type: .photoLibrary)
    }
    
    func didDeleteImage() {
        print("Delete")
    }
    
    func presentProfilePicturePicker(type: PicturePickerType) {
        let picker = UIImagePickerController()
        picker.sourceType = type == .camera ? .camera : .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ChangePictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[
            UIImagePickerController.InfoKey.editedImage
        ] as? UIImage else {
            return
        }
        //.image = image
        //blurView.removeFromSuperview()
    }
}

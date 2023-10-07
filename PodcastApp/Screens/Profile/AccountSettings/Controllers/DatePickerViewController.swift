//
//  DatePickerViewController.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 07.10.2023.
//

import UIKit

class DatePickerViewController: UIViewController {

    //MARK: - UI Components
    
    let dPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.timeZone = TimeZone.current
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let pickerHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        //changePicturePopUp.delegate = self
        addSubviews()
        setupConstraints()
        setupTapGesture()
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        view.addSubview(blurEffectView)
        pickerHolderView.addSubview(dPicker)
        view.addSubview(pickerHolderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pickerHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            pickerHolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            pickerHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            dPicker.topAnchor.constraint(equalTo: pickerHolderView.topAnchor, constant: 20.0),
            dPicker.leadingAnchor.constraint(equalTo: pickerHolderView.leadingAnchor, constant: 20.0),
            dPicker.trailingAnchor.constraint(equalTo: pickerHolderView.trailingAnchor, constant: -20.0),
            dPicker.bottomAnchor.constraint(equalTo: pickerHolderView.bottomAnchor, constant: -20.0),
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
    
    private func addTargets() {
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        
        dPicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let resultDate = dateFormatter.string(from: sender.date)
        return resultDate
    }
}


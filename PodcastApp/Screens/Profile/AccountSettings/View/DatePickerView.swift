//
//  DatePickerView.swift
//  PodcastApp
//
//  Created by Caroline Tikhomirova on 07.10.2023.
//

import UIKit

class DatePickerView: UIView {
    
    //MARK: - Properties
    
    var changeClosure: ((Date)->())?
    var dismissClosure: (()->())?
    
    //MARK: - UI Components
    
    let dPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.timeZone = TimeZone.current
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pickerHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        addTargets()
        setupTapGesture()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func addSubviews() {
        addSubview(blurEffectView)
        pickerHolderView.addSubview(dPicker)
        addSubview(pickerHolderView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            pickerHolderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            pickerHolderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            pickerHolderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            dPicker.topAnchor.constraint(equalTo: pickerHolderView.topAnchor, constant: 20.0),
            dPicker.leadingAnchor.constraint(equalTo: pickerHolderView.leadingAnchor, constant: 20.0),
            dPicker.trailingAnchor.constraint(equalTo: pickerHolderView.trailingAnchor, constant: -20.0),
            dPicker.bottomAnchor.constraint(equalTo: pickerHolderView.bottomAnchor, constant: -20.0),
            
        ])
    }
    
    private func addTargets() {
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        
        dPicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        blurEffectView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ g: UITapGestureRecognizer) -> Void {
        dismissClosure?()
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) -> Void {
        changeClosure?(sender.date)
    
    }
    
}

//class ViewController: UIViewController {
//
//    let myPicker: MyDatePicker = {
//        let v = MyDatePicker()
//        return v
//    }()
//
//    let myButton: UIButton = {
//        let v = UIButton()
//        v.setTitle("Show Picker", for: [])
//        v.setTitleColor(.white, for: .normal)
//        v.setTitleColor(.lightGray, for: .highlighted)
//        v.backgroundColor = .blue
//        return v
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        [myButton, myPicker].forEach { v in
//            v.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(v)
//        }
//        let g = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//
//            // custom picker view should cover the whole view
//            myPicker.topAnchor.constraint(equalTo: g.topAnchor),
//            myPicker.leadingAnchor.constraint(equalTo: g.leadingAnchor),
//            myPicker.trailingAnchor.constraint(equalTo: g.trailingAnchor),
//            myPicker.bottomAnchor.constraint(equalTo: g.bottomAnchor),
//
//            myButton.centerXAnchor.constraint(equalTo: g.centerXAnchor),
//            myButton.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
//            myButton.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.75),
//
//        ])
//
//        // hide custom picker view
//        myPicker.isHidden = true
//
//        // add closures to custom picker view
//        myPicker.dismissClosure = { [weak self] in
//            guard let self = self else {
//                return
//            }
//            self.myPicker.isHidden = true
//        }
//        myPicker.changeClosure = { [weak self] val in
//            guard let self = self else {
//                return
//            }
//            print(val)
//            // do something with the selected date
//        }
//
//        // add button action
//        myButton.addTarget(self, action: #selector(tap(_:)), for: .touchUpInside)
//    }
//
//    @objc func tap(_ sender: Any) {
//        myPicker.isHidden = false
//    }
//
//}

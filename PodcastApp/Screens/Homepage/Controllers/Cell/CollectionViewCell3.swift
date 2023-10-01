//
//  TrainingCellView.swift
//  WorkoutApp
//
//  Created by Максим Нурутдинов on 28.09.2023.
//

import UIKit

final class CollectionViewCell3: UICollectionViewCell {
    static let id = "CollectionViewCell"
    
    let constantRetreat = CGFloat(10)
    
    let heartView: UIImageView = {
        let imageView = UIImageView(image: R.Images.Overview.heartImage)
        imageView.tintColor = R.Colors.heartNotDone
        return imageView
    }()
    
    var isFilled: Bool = false {
        didSet {
            // Меняем цвет изображения в зависимости от состояния
            let imageColor = isFilled ? R.Colors.heartDone : R.Colors.heartNotDone
            heartView.tintColor = imageColor
        }
    }
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        return view
    }()
    
    private let stackView2: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        return view
    }()
    
    private let title: UILabel = {
        let lable = UILabel()
        lable.text = "Sruput Nendang"
        lable.font = R.Fonts.helvelticaRegular(with: 14)
        lable.textColor = R.Colors.titleGray
        return lable
    }()
    
    private let subtitle: UILabel = {
        let lable = UILabel()
        lable.text = "Music & Fun"
        lable.font = R.Fonts.helvelticaRegular(with: 12)
        lable.textColor = R.Colors.inactive
        return lable
    }()
    private let title2: UILabel = {
        let lable = UILabel()
        lable.text = "Gofar Hilman"
        lable.font = R.Fonts.helvelticaRegular(with: 12)
        lable.textColor = R.Colors.titleGray
        return lable
    }()
    
    private let subtitle2: UILabel = {
        let lable = UILabel()
        lable.text = "23 Eps"
        lable.font = R.Fonts.helvelticaRegular(with: 12)
        lable.textColor = R.Colors.inactive
        return lable
    }()
    
    private let imagePinkView: UIImageView = {
        let imagePinkView = UIImageView()
        imagePinkView.image = R.Images.Overview.imagePink
        imagePinkView.layer.cornerRadius = 16
        imagePinkView.layer.masksToBounds = true
        return imagePinkView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupViews()
        constaintViews()
        heartViewTap()
//        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        
        //        setupViews()
        //        constaintViews()
        //        heartViewTap()
//                configureAppearance()
    }
}

private extension CollectionViewCell3 {
//    // Загрузите JSON из файла или с удаленного сервера
//    func configureAppearance() {
//        if let url = URL(string: "https://") {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                if let data = data {
//                    do {
//                        // Распарсите JSON
//                        let myData = try JSONDecoder().decode(MyData.self, from: data)
//
//                        // Обновите UI на основе данных из JSON
//                        DispatchQueue.main.async { [self] in
//                            title.text = myData.objectId
//                        }
//                    } catch {
//                        print("Ошибка при распарсивании JSON: \(error)")
//                    }
//                } else if let error = error {
//                    print("Ошибка при загрузке данных: \(error)")
//                }
//            }.resume()
//        }
//    }
    
    func setupViews() {
    setupView(heartView)
        setupView(stackView)
        setupView(stackView2)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        stackView2.addArrangedSubview(title2)
        stackView2.addArrangedSubview(subtitle2)
        setupView(imagePinkView)
        
    }
    
    func constaintViews() {
        NSLayoutConstraint.activate([
            imagePinkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constantRetreat),
            imagePinkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imagePinkView.heightAnchor.constraint(equalToConstant: 56),
            imagePinkView.widthAnchor.constraint(equalToConstant: 56),
            
            stackView.leadingAnchor.constraint(equalTo: imagePinkView.trailingAnchor, constant: constantRetreat),
            stackView.trailingAnchor.constraint(equalTo: stackView2.leadingAnchor, constant: -constantRetreat),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView2.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: constantRetreat),
            stackView2.trailingAnchor.constraint(equalTo: heartView.leadingAnchor, constant: -constantRetreat),
            stackView2.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heartView.centerYAnchor.constraint(equalTo: centerYAnchor),
            heartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constantRetreat),
            heartView.heightAnchor.constraint(equalToConstant: 19),
            heartView.widthAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    func heartViewTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleHeartTap))
        heartView.addGestureRecognizer(tapGesture)
        heartView.isUserInteractionEnabled = true
    }
    
    @objc func handleHeartTap() {
        // Переключите значение isFilled
        isFilled = !isFilled
        
        // Здесь вы можете выполнить дополнительные действия, связанные с нажатием сердца, если это необходимо
    }

}


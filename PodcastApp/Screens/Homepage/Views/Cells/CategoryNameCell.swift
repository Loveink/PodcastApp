//
//  CategoryCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class CategoryNameCell: UICollectionViewCell {

  static let identifier = "CategoryCell"
  private let categoryLabel = UILabel.makeLabel(text: "", font: .manropeRegular(size: 16), textColor: .textGrey)

  override var isSelected: Bool {
          didSet {
              if isSelected {
                  addShadow()
                  backgroundColor = .white
                  categoryLabel.font = .manropeBold(size: 16)
                  categoryLabel.textColor = .black
              } else {
                  removeShadow()
                  backgroundColor = .clear
                  categoryLabel.textColor = .textGrey
                  categoryLabel.font = .manropeRegular(size: 16)
              }
          }
      }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupUICell()
  }

  func setupUICell() {
    backgroundColor = .white
    layer.masksToBounds = false
    layer.cornerRadius = 15
    categoryLabel.numberOfLines = 1
    categoryLabel.textAlignment = .center
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configure(with title: String) {
    categoryLabel.text = title
  }

  private func setupViews() {
    contentView.addSubview(categoryLabel)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }

  func addShadow() {
          layer.masksToBounds = false
          layer.shadowColor = UIColor.black.cgColor
          layer.shadowOpacity = 0.2
          layer.shadowOffset = CGSize(width: 0, height: 2)
          layer.shadowRadius = 5
      }

      func removeShadow() {
          layer.masksToBounds = true
          layer.shadowOpacity = 0
      }
}

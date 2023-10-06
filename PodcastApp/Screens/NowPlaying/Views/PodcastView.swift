//
//  PodcastView.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
//


import UIKit

final class PodcastView: UIView {

  lazy var songNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 2
    label.text = "Robot Rock"
    label.font = .manropeBold(size: 20)
    label.textColor = .black
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var performerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Daft Punk"
    label.font = .manropeRegular(size: 16)
    label.textColor = .textGrey
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var buttonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  lazy var sliderView: UISlider = {
    let slider = UISlider()
    slider.thumbTintColor = .black
    slider.minimumTrackTintColor = .blue
    slider.maximumTrackTintColor = .blueBorder
    slider.maximumValue = 0.00
    slider.maximumValue = 3
    slider.value = 2
    slider.translatesAutoresizingMaskIntoConstraints = false

    return slider
  }()

  lazy var leftSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.textColor = .black
    label.text = "00:00"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label

  }()

  lazy var rightSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label

  }()

  lazy var shuffleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "shuffle 1"), for: .normal)
    button.tintColor = .gray
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var previousTrackButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "next 2"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var playButton: UIButton = {
    let button = UIButton(type: .custom)
        button.tintColor = .blue
    button.setImage(UIImage(named: "play"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var nextTrackButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "next 1"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var repeatButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "repeat"), for: .normal)
    button.tintColor = .gray
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {
    addSubview(songNameLabel)
    addSubview(performerNameLabel)
    addSubview(sliderView)
    addSubview(leftSliderLabel)
    addSubview(rightSliderLabel)
    addSubview(buttonsStackView)

    buttonsStackView.addArrangedSubview(shuffleButton)
    buttonsStackView.addArrangedSubview(previousTrackButton)
    buttonsStackView.addArrangedSubview(playButton)
    buttonsStackView.addArrangedSubview(nextTrackButton)
    buttonsStackView.addArrangedSubview(repeatButton)

    NSLayoutConstraint.activate([

      songNameLabel.topAnchor.constraint(equalTo: topAnchor),
      songNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
      songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),

      performerNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10),
      performerNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      sliderView.topAnchor.constraint(equalTo: performerNameLabel.bottomAnchor, constant: 20),
      sliderView.centerXAnchor.constraint(equalTo: centerXAnchor),
      sliderView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

      leftSliderLabel.trailingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: -10),
      leftSliderLabel.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),

      rightSliderLabel.leadingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: 10),
      rightSliderLabel.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),

      buttonsStackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 30),
      buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      buttonsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
      buttonsStackView.heightAnchor.constraint(equalToConstant: 80)
    ])
  }
}

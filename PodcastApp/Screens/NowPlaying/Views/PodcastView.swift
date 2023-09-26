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
    label.numberOfLines = 1
    label.text = "Robot Rock"
    label.font = .systemFont(ofSize: 30)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var performerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Daft Punk"
    label.font = .systemFont(ofSize: 20)
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var backHomeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "arrow_back"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  lazy var shareButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "share"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
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
    slider.thumbTintColor = .blue
    slider.thumbTintColor = .blue
    slider.minimumTrackTintColor = .blue
    slider.maximumTrackTintColor = .blueBorder
    slider.maximumValue = 0.00
    slider.maximumValue = 3.05
    slider.value = 2.43
    slider.translatesAutoresizingMaskIntoConstraints = false
    return slider
  }()
  
  lazy var leftSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 30)
    label.textColor = .black
    label.text = "0"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
    
  }()
  
  lazy var rightSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 30)
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
//    button.tintColor = .blue
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

      performerNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10),
      performerNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      sliderView.topAnchor.constraint(equalTo: performerNameLabel.bottomAnchor, constant: 20),
      sliderView.centerXAnchor.constraint(equalTo: centerXAnchor),
      sliderView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),

      leftSliderLabel.trailingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: -10),
      leftSliderLabel.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),

      rightSliderLabel.leadingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: 10),
      rightSliderLabel.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),

      buttonsStackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 30),
      buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),




    ])
  }
}


//
//  PodcastView.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
//

import UIKit
import AVFoundation


final class PodcastView: UIView {

  var audioPlayer: AVAudioPlayer?
  var currentTrackIndex: Int = 0
  var musicArray: [String?] = []
  var dur: Int = 0
  
  lazy var songNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 1
    label.text = "Robot Rock"
    label.font = .manropeBold(size: 20)
    label.textColor = .black
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
    slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

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
    label.text = String(dur)
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
    button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
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
  
  @objc func sliderValueChanged(_ slider: UISlider) {
      let durationInMilliseconds = Float(dur)
      let durationInSeconds = durationInMilliseconds / 1000.0 // Convert milliseconds to seconds

      let currentTime = slider.value * durationInSeconds
      audioPlayer?.currentTime = TimeInterval(currentTime)
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
      sliderView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),

      leftSliderLabel.trailingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: -10),
      leftSliderLabel.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),

      rightSliderLabel.leadingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: 10),
      rightSliderLabel.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),

      buttonsStackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 30),
      buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),




    ])
  }

  @objc func playButtonTapped() {
    if let audioPlayer = audioPlayer {
      if audioPlayer.isPlaying {
        audioPlayer.pause()
        playButton.setImage(UIImage(named: "play"), for: .normal)
      } else {
        audioPlayer.play()
        playButton.setImage(UIImage(named: "pause"), for: .normal)
      }
    } else {
      // If audioPlayer is nil, you may want to handle this case (e.g., start playback from the beginning).
      if let audioURLString = musicArray.first, let audioURLStringUnwrapped = audioURLString, let audioURL = URL(string: audioURLStringUnwrapped + ".mp3") {
          playTrack(withURL: audioURL)
      }
    }
  }

  func playTrack(withURL audioURL: URL) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
      audioPlayer?.delegate = self
      audioPlayer?.prepareToPlay()
      audioPlayer?.play()
      playButton.setImage(UIImage(named: "pause"), for: .normal)
    } catch {
      print("Error playing audio: \(error)")
    }
  }
}


extension PodcastView: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
      if flag {
        // Track finished, you can handle this event here.
        // For example, move to the next track if available.
        currentTrackIndex += 1
        if currentTrackIndex < musicArray.count {
          if let audioURLString = musicArray[currentTrackIndex], let audioURL = URL(string: audioURLString + ".mp3") {
            playTrack(withURL: audioURL)
          }
        } else {
          // No more tracks to play, you can handle this case accordingly.
        }
      }
    }
  }

//
//  NowPlayingViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 25.09.2023.
//

import UIKit
import AVFoundation
import Kingfisher

class NowPlayingViewController: UIViewController {

  var podcast = PodcastView()
  private lazy var chanelVC = ChannelViewController()

  private let musicPlayer = MusicPlayer.instance
  private var currentTrackModel: EpisodeItem?

  var trackInfo: EpisodeItem? {
      didSet {
        if trackInfo != nil {
          }
      }
  }
  var audioPlayer: AVAudioPlayer?
  var currentTrackIndex: Int = 0
  var musicArray: [String] = []
  private var timer: Timer?
  var channelAuthor: String?

  private lazy var titleLabel = UILabel.makeLabel(text: "Now playing", font: UIFont.plusJakartaSansBold(size: 18), textColor: UIColor.black)

  private lazy var backButton: UIButton = {
      let button = UIButton(type: .system)
      button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
      button.tintColor = .symbolsPurple
      button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
  }()

  var channelImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = 12
      imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
  }()

  @objc private func backButtonTapped() {
      dismiss(animated: true) {
          if let presentingVC = self.presentingViewController as? ChannelViewController {
              presentingVC.tabBarController?.tabBar.isHidden = false
              presentingVC.navigationController?.popToViewController(presentingVC, animated: true)
          }
      }
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    setDurationTime()
    setTargets()
    updateButtonImage(isPlay: false)
    startTimer()
    if let trackInfo = trackInfo {
      configureCell(with: trackInfo)
    }
    if let channelAuthor = channelAuthor {
            podcast.performerNameLabel.text = channelAuthor
        }
  }

  deinit {
      stopTimer()
    }

  private func startTimer() {
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCurrentTime), userInfo: nil, repeats: true)
    }

    // Функция для остановки таймера
    private func stopTimer() {
      timer?.invalidate()
      timer = nil
    }

  func setDurationTime() {
      let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
  }

  @objc private func updateCurrentTime() {
      let currentTime = musicPlayer.getCurrentTime()
      podcast.leftSliderLabel.text = "\(convertSecondsToMinutes(Float(currentTime)))"
      podcast.sliderView.value = Float(currentTime)
  }


  func setupConstraints() {
    podcast.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(podcast)
    view.addSubview(backButton)
    view.addSubview(titleLabel)
    view.addSubview(channelImageView)

    NSLayoutConstraint.activate([
      backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

      titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),


      channelImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      channelImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      channelImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      channelImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

      podcast.topAnchor.constraint(equalTo: channelImageView.bottomAnchor, constant: 50),
      podcast.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      podcast.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      podcast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func configureCell(with musicResult: EpisodeItem) {
      currentTrackModel = musicResult
      podcast.songNameLabel.text = musicResult.title
      podcast.performerNameLabel.text = channelAuthor
  }


  private func setTargets() {
      podcast.sliderView.addTarget(self, action: #selector(rewindTrack), for: [.touchUpInside])
      podcast.playButton.addTarget(self, action: #selector(controlPlayer), for: .touchUpInside)
      podcast.nextTrackButton.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
      podcast.previousTrackButton.addTarget(self, action: #selector(previousTrack), for: .touchUpInside)
    }

    private func convertSecondsToMinutes(_ totalSeconds: Float) -> Float {
        let minute = Float(Int(totalSeconds) % 3600 / 60)
        let seconds = Float(Int(totalSeconds) % 60)

        return Float(minute + (seconds / 100))
    }

  @objc private func controlPlayer() {
      musicPlayer.isPlayerPerforming() ? musicPlayer.pauseMusic() : musicPlayer.playMusic()
  }

    @objc private func rewindTrack() {
        let currentTime = Int(podcast.sliderView.value)
        musicPlayer.rewindTrack(at: Float(currentTime))
        musicPlayer.playMusic()
        updateCurrentTimeLabel(duration: currentTime)
    }

  @objc private func nextTrack() {
      musicPlayer.playNextSong()
      if let trackInfo = trackInfo {
          configureCell(with: trackInfo)
      }
      let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
      updateCurrentTimeLabel(duration: 0)
    DispatchQueue.main.async {
      self.updateButtonImage(isPlay: self.musicPlayer.isPlayerPerforming())
    }

  }

  @objc private func previousTrack() {
      musicPlayer.playPreviousSong()
      if let trackInfo = trackInfo {
          configureCell(with: trackInfo)
      }
      let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
      updateCurrentTimeLabel(duration: 0)
    DispatchQueue.main.async {
      self.updateButtonImage(isPlay: self.musicPlayer.isPlayerPerforming())
    }

  }


  func updateButtonImage(isPlay: Bool) {
    
      let image = isPlay ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play")
      podcast.playButton.setImage(image, for: .normal)
  }


    func updateCurrentTimeLabel(duration: Int) {
        let currentTime = Int(podcast.sliderView.value)
        podcast.leftSliderLabel.text = "\(convertSecondsToMinutes(Float(currentTime)))"
    }


    func updateTotalDuration(duration: Float) {
      podcast.sliderView.maximumValue = convertSecondsToMinutes(duration)
    }

    func updateSlider(value: Float) {
        let newValue = value / podcast.sliderView.maximumValue

      podcast.sliderView.value = podcast.sliderView.maximumValue * newValue
    }
  }

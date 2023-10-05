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
  var galleryViewController = GalleryView()

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


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupConstraints()
    setDurationTime()
    setTargets()
    updateButtonImage(isPlay: false)
    startTimer()
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

  @objc private func updateCurrentTime() {
      let currentTime = musicPlayer.getCurrentTime()
      podcast.leftSliderLabel.text = "\(convertSecondsToMinutes(Float(currentTime)))"
      podcast.sliderView.value = Float(currentTime)
    }

  func setupConstraints() {
    galleryViewController.translatesAutoresizingMaskIntoConstraints = false
    podcast.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(galleryViewController)
    view.addSubview(podcast)

    NSLayoutConstraint.activate([
      galleryViewController.topAnchor.constraint(equalTo: view.topAnchor),
      galleryViewController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      galleryViewController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      galleryViewController.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),

      podcast.topAnchor.constraint(equalTo: galleryViewController.bottomAnchor, constant: -100),
      podcast.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      podcast.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      podcast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  func configureCell(with musicResult: EpisodeItem) {
    currentTrackModel = musicResult

    podcast.songNameLabel.text = musicResult.title

    let imageUrlString = musicResult.feedImage
//    if let imageUrl = URL(string: imageUrlString) {
//      if let firstImageView = galleryViewController.images.first {
//        firstImageView.kf.setImage(with: imageUrl)
//      }
//    }
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
        let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
        updateCurrentTimeLabel(duration: 0)
    }

    @objc private func previousTrack() {
        musicPlayer.playPreviousSong()
        let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
        updateCurrentTimeLabel(duration: 0)
    }


    func setDurationTime() {
        let duration = musicPlayer.getTrackDuration()
      podcast.rightSliderLabel.text = "\(convertSecondsToMinutes(Float(duration)))"
      podcast.sliderView.maximumValue = Float(duration)
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

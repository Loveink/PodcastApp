//
//  MiniPlayerVC.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit

protocol MiniPlayerViewDelegate: AnyObject {
    func playButtonTapped()
    func forwardButtonTapped()
    func backwardButtonTapped()
}

class MiniPlayerVC: UIView {

    weak var delegate: MiniPlayerViewDelegate?

    private let musicPlayer = MusicPlayer.instance

    private let backgroundView = UIView()
    var songImageView = UIImageView()
    let songTitleLabel = UILabel()
    let songArtist = UILabel()
    private let backButton = UIButton(type: .system)
    let playButton = UIButton(type: .system)
    private let forwardButton = UIButton(type: .system)
    private var targetController: UIViewController?
    private var currentViewController: UIViewController?

    init() {
        super.init(frame: .zero)
        backgroundView.backgroundColor = UIColor(red: 0.8, green: 0.882, blue: 0.984, alpha: 1)
      backgroundView.layer.cornerRadius = 12
      songImageView.layer.cornerRadius = 20
      songImageView.layer.masksToBounds = true

        setupViews()
        setupConstraints()
        addGestureToBackgroundView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(backgroundView)
        backgroundView.addSubview(songImageView)
        backgroundView.addSubview(songTitleLabel)
        backgroundView.addSubview(songArtist)
        backgroundView.addSubview(backButton)
        backButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .black

        addSubview(forwardButton)
        forwardButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        forwardButton.tintColor = .black

        addSubview(playButton)
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.tintColor = .black
    }

    private func setupConstraints() {

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        songArtist.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),

            songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            songImageView.widthAnchor.constraint(equalToConstant: 40),
            songImageView.heightAnchor.constraint(equalToConstant: 40),

            songTitleLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songTitleLabel.centerYAnchor.constraint(equalTo: songImageView.centerYAnchor),
            songTitleLabel.widthAnchor.constraint(equalToConstant: 230),

            songArtist.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songArtist.bottomAnchor.constraint(equalTo: songImageView.bottomAnchor, constant: -2),
            songArtist.widthAnchor.constraint(equalToConstant: 180),

            backButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -2),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            playButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -2),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            forwardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func updateSongTitle(_ title: String) {
        songTitleLabel.text = title
    }

    func updateSongArtist(_ title: String) {
        songArtist.text = title
    }

    func updateSongImage(_ image: UIImage?) {
        songImageView.image = image
    }

  func setupCurrentViewController(controller: UIViewController) {
      currentViewController = controller
  }

  func setupTargetController(controller: UIViewController) {
      targetController = controller
  }
  
    private func addGestureToBackgroundView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(switchToSongPageViewController))
        let removeGesture = UISwipeGestureRecognizer(target: self, action: #selector(removeMiniPlayerFromParentView))

        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(gesture)
        backgroundView.addGestureRecognizer(removeGesture)
    }

    @objc private func switchToSongPageViewController() {
        guard let targetVC = targetController, let currentVC = currentViewController else { return }
        targetVC.modalPresentationStyle = .overFullScreen
        currentVC.present(targetVC, animated: true)
    }


    @objc private func backButtonTapped() {
        delegate?.backwardButtonTapped()
    }

    @objc private func playButtonTapped() {
        delegate?.playButtonTapped()
    }

    @objc private func forwardButtonTapped() {
        delegate?.forwardButtonTapped()
    }

    @objc func removeMiniPlayerFromParentView() {
        UIView.animate(withDuration: 1) {
            self.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.closeMiniPlayer()
            self.alpha = 1
        }
    }

    func closeMiniPlayer() {
        self.removeFromSuperview()
        musicPlayer.pauseMusic()
    }
}

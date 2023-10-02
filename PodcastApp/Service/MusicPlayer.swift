//
//  MusicPlayer.swift
//  PodcastApp
//
//  Created by Александра Савчук on 30.09.2023.
//

import Foundation
import AVFoundation

protocol MusicPlayerDelegate: AnyObject {
    func updatePlayButtonState(isPlaying: Bool)
    func updateCurrentURL(_ url: String)
}

class MusicPlayer {
    enum PlayerType {
        case musicResults
        case musicSearch
    }

    static let instance = MusicPlayer()

    weak var songController: SongViewControllerProtocol?
    weak var delegate: MusicPlayerDelegate?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentURL: String?
    private var currentSongIndex: Int = 0
    private var currentPlayerType: PlayerType = .musicResults
    private var musicResults: [EpisodeItemCell] = []

    func loadPlayer(from episode: EpisodeItemCell) {
      guard let musicURL = URL(string: episode.audioURL) else {
            print("Invalid music URL")
            return
        }

        currentPlayerType = .musicResults

        playerItem = AVPlayerItem(url: musicURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
      currentURL = episode.audioURL
        delegate?.updatePlayButtonState(isPlaying: true)
      delegate?.updateCurrentURL(episode.audioURL)
        songController?.setDurationTime()
        songController?.updateButtonImage(isPlay: true)
        updatePlayerValues()
    }

    func playMusicWithURL(_ episode: EpisodeItemCell) {
      if isPlayingMusic(from: episode.audioURL) {
            pauseMusic()
        } else {
            loadPlayer(from: episode)
          currentURL = episode.audioURL
        }
    }

    func playMusic() {
        player?.play()
        delegate?.updatePlayButtonState(isPlaying: true)
        songController?.updateButtonImage(isPlay: true)
    }

    func pauseMusic() {
        player?.pause()
        delegate?.updatePlayButtonState(isPlaying: false)
        songController?.updateButtonImage(isPlay: false)
    }

    func stopMusic() {
        player?.pause()
        player = nil
        currentURL = nil
        delegate?.updatePlayButtonState(isPlaying: false)
        delegate?.updateCurrentURL("")
    }

    func isPlayingMusic(from url: String) -> Bool {
        return currentURL == url && player?.rate != 0 && player?.error == nil
    }

    func isPlayerPerforming() -> Bool {
        return player?.timeControlStatus == .playing ? true : false
    }

    func getTrackDuration() -> Double {
        guard let duration = player?.currentItem?.asset.duration else { return 0 }
        return duration.seconds
    }

  func updatePlayerValues() {
      player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 60), queue: DispatchQueue.main) { [weak self] CMTime in
          guard let self = self else { return }
          self.songController?.updateSlider(value: Float(CMTime.seconds))
          self.songController?.updateCurrentTimeLabel(duration: Int(CMTime.seconds))
      }
  }

    func rewindTrack(at time: Float) {
        player?.seek(to: CMTime(seconds: Double(time), preferredTimescale: 1000))
    }

    func playNextSong() {
        currentSongIndex += 1
        if currentSongIndex >= musicResults.count {
            currentSongIndex = 0
        }
        let nextEpisode = musicResults[currentSongIndex]
        loadPlayer(from: nextEpisode)
    }

    func playPreviousSong() {
        currentSongIndex -= 1
        if currentSongIndex < 0 {
            currentSongIndex = musicResults.count - 1
        }
        let previousEpisode = musicResults[currentSongIndex]
        loadPlayer(from: previousEpisode)
    }

    func updateMusicResults(_ results: [EpisodeItemCell]) {
        musicResults = results
        currentSongIndex = 0
    }
}

extension MusicPlayer: MusicPlayerDelegate {
    func updatePlayButtonState(isPlaying: Bool) {
        delegate?.updatePlayButtonState(isPlaying: isPlaying)
    }

    func updateCurrentURL(_ url: String) {
        delegate?.updateCurrentURL(url)
    }
}

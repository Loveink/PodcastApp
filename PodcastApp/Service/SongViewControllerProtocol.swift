//
//  SongViewControllerProtocol.swift
//  PodcastApp
//
//  Created by Александра Савчук on 01.10.2023.
//

import UIKit

protocol SongViewControllerProtocol: AnyObject {
    func configureCell(with musicResult: EpisodeItem)
    func updateButtonImage(isPlay: Bool)
    func updateCurrentTimeLabel(duration: Int)
    func updateTotalDuration(duration: Float)
    func updateSlider(value: Float)
    func setDurationTime()
}

//
//  PodcastView.swift
//  PodcastApp
//
//  Created by Александра Савчук on 26.09.2023.
//

import UIKit

final class PodcastView: UIView {
  
  lazy var backHomeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "arrow_back"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  
  lazy var songPageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.layer.cornerRadius = 1.5
    pageControl.numberOfPages = 2
    pageControl.currentPage = 0
    pageControl.currentPageIndicatorTintColor = .white
    pageControl.pageIndicatorTintColor = .gray
    pageControl.frame = CGRect(x: 0, y: 0, width: 45, height: 3)
    
    return pageControl
  }()
  
  lazy var songImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = 104
    imageView.layer.masksToBounds = true
    imageView.image = UIImage(named: "SongImage1")
    
    return imageView
  }()
  
  lazy var songNameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 1
    label.text = "Robot Rock"
    label.font = .systemFont(ofSize: 30)
    label.textColor = .white
    
    return label
  }()
  
  lazy var performerNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Daft Punk"
    label.font = .systemFont(ofSize: 30)
    label.textColor = .white
    
    return label
  }()
  
  lazy var describingSongLabel: UILabel = {
    let label = UILabel()
    label.text = "Your favorite musical player!"
    label.backgroundColor = .systemGray.withAlphaComponent(0.3)
    label.font = .systemFont(ofSize: 30)
    label.textColor = .green
    
    return label
  }()
  
  lazy var shareButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "share"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  //
  //    lazy var addToAlbomButton: UIButton = {
  //        let button = UIButton(type: .system)
  //        button.setImage(UIImage(named: "addToAlbom"), for: .normal)
  //        button.tintColor = .white
  //
  //        return button
  //    }()
  
  lazy var likeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  
  //    lazy var downloadButton: UIButton = {
  //        let button = UIButton(type: .system)
  //        button.setImage(UIImage(named: "download"), for: .normal)
  //        button.tintColor = .white
  //
  //        return button
  //    }()
  
  lazy var topButtonsStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  lazy var sliderView: UISlider = {
    let slider = UISlider()
    slider.thumbTintColor = .green
    slider.thumbTintColor = .green
    slider.minimumTrackTintColor = .green
    slider.maximumTrackTintColor = .gray
    slider.maximumValue = 0.00
    slider.maximumValue = 3.05
    slider.value = 2.43
    
    return slider
  }()
  
  lazy var leftSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 30)
    label.textColor = .white
    label.text = "0"
    
    return label
    
  }()
  
  lazy var rightSliderLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 30)
    label.textColor = .white
    
    return label
    
  }()
  
  //    lazy var shuffleButton: UIButton = {
  //        let button = UIButton(type: .system)
  //        button.setImage(UIImage(named: "shuffle"), for: .normal)
  //        button.tintColor = .white
  //
  //        return button
  //    }()
  
  lazy var previousTrackButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "backward.end"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  
  lazy var playButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .black
    button.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
    button.backgroundColor = .green
    button.layer.cornerRadius = 37
    button.layer.masksToBounds = true
    button.layer.shadowColor = UIColor.green.cgColor
    button.layer.shadowOpacity = 1
    button.layer.shadowOffset = CGSize(width: 30, height: 30)
    button.layer.shadowRadius = 15
    
    return button
  }()
  
  lazy var nextTrackButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "forward.end"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  
  lazy var repeatButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "shuffle"), for: .normal)
    button.tintColor = .white
    
    return button
  }()
  
}

//
//  FetchFunc.swift
//  PodcastApp
//
//  Created by Александра Савчук on 30.09.2023.
//

import Foundation
import AVFoundation
import UIKit

class FetchFunc: UIViewController {
  
  var audioPlayer: AVAudioPlayer?
  var musicArray: [String] = []
  var collectionView: UICollectionView
  
  init(collectionView: UICollectionView) {
    self.collectionView = collectionView
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func fetch(completion: @escaping () -> Void) {
    let dispatchGroup = DispatchGroup()
    let xmls = [String]()
    dispatchGroup.enter()
    completion()
    dispatchGroup.notify(queue: .main) {
      self.handlePodcastFetchCompletion(xmls, collectionView1: self.collectionView)
    }
  }
  
  func fetchXMLs(_ xmls: [String], dispatchGroup: DispatchGroup) {
    for xmlURLString in xmls {
      guard let xmlURL = URL(string: xmlURLString) else {
        continue
      }
      
      dispatchGroup.enter()
      let session = URLSession.shared
      let task = session.dataTask(with: xmlURL) { (data, response, error) in
        defer {
          dispatchGroup.leave()
        }
        
        if let error = error {
          print("Error: \(error.localizedDescription)")
          return
        }
        
        if let data = data {
          self.parseXML(data)
        }
      }
      task.resume()
    }
  }
  
  func parseXML(_ data: Data) {
    let xmlParser = XMLParser(data: data)
    xmlParser.delegate = self
    xmlParser.parse()
    
  }
  
  func handlePodcastFetchCompletion(_ xmls: [String], collectionView1: UICollectionView) {
    collectionView1.reloadData()
  }

    func getMusic(audioURL: String?) {
        guard let audioURLString = audioURL, let audioURL = URL(string: audioURLString + ".mp3") else {
            print("URL for audio is invalid.")
            return
        }

        playAudio(withURL: audioURL)
        print("play")
    
  }

  func playAudio(withURL audioURL: URL) {
    let session = URLSession.shared
    let task = session.dataTask(with: audioURL) { [weak self] (data, response, error) in
      if let error = error {
        print("Error loading audio data: \(error.localizedDescription)")
        return
      }
      
      if let data = data {
        do {
          self?.audioPlayer = try AVAudioPlayer(data: data)
          //                  self?.audioPlayer?.delegate = self
          self?.audioPlayer?.play()
        } catch {
          print("Error creating audio player: \(error)")
          print(audioURL)
        }
      }
    }
    task.resume()
  }
}

extension FetchFunc: XMLParserDelegate {
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    if elementName == "enclosure", let enclosureURL = attributeDict["url"] {
      musicArray.append(enclosureURL)
    }
  }
}

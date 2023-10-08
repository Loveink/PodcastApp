//
//  FavoritesViewController.swift
//  PodcastApp
//
//  Created by Александра Савчук on 23.09.2023.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

// MARK: - User Interface
    private lazy var favouriteChanelsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

  private let titleLabel = UILabel.makeLabel(text: "Favorites", font: .manropeBold(size: 16), textColor: .black)

// MARK: - private properties
    var favouriteChanels: [PodcastItemCell] = []
//    private var favouriteChanels = ChannelModel.makeMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupTableView()
      setupNavigationBar()
      loadPodcastDataFromCoreData()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadPodcastDataFromCoreData()
  }

// MARK: - Private methodes
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(favouriteChanelsTableView)
    }

    private func setupTableView() {
        favouriteChanelsTableView.dataSource = self
        favouriteChanelsTableView.delegate = self
        
        favouriteChanelsTableView.register(
            FavouriteChannelCell.self,
            forCellReuseIdentifier: FavouriteChannelCell.reuseIdentifier)
        
        favouriteChanelsTableView.estimatedRowHeight = 48
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
    }

  private func loadPodcastDataFromCoreData() {
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          let context = appDelegate.persistentContainer.viewContext

          do {
              let fetchRequest: NSFetchRequest<PodcastSave> = PodcastSave.fetchRequest()
              let podcastData = try context.fetch(fetchRequest)

              favouriteChanels = podcastData.map { podcast in
                  return PodcastItemCell(
                    title: podcast.title ?? "",
                    image: podcast.image ?? "",
                    id: Int(podcast.id),
                    author: podcast.author ?? "",
                    categories: ["": ""]
                  )
              }
            
              favouriteChanelsTableView.reloadData()
          } catch {
              print("Ошибка при загрузке данных из Core Data: \(error)")
          }
      }

  func didSelectPodcast(id: Int) {
    guard let selectedFeed = favouriteChanels.first(where: { $0.id == id }) else {
      return
    }

    let channelVC = ChannelViewController()
    channelVC.channelID = id
    channelVC.channelTitleLabel.text = selectedFeed.title
    channelVC.channelAuthor.text = selectedFeed.author
    channelVC.placeholderImage = UIImage(named: "placeholder_image")

    if let imageURL = URL(string: selectedFeed.image) {
      URLSession.shared.dataTask(with: imageURL) { (data, _, _) in
        if let data = data, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            channelVC.channelImageView.image = image
          }
        }
      }.resume()
    }
    self.navigationController?.pushViewController(channelVC, animated: true)
  }
}


// MARK: - table protocols
extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteChanels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FavouriteChannelCell.reuseIdentifier,
            for: indexPath) as? FavouriteChannelCell else {
            let cell = FavouriteChannelCell()
            return cell
        }
        
        let favCahel = self.favouriteChanels[indexPath.row]
        cell.setup(withChanel: favCahel)
        return cell
    }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if favouriteChanels.count > 0 {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? FavouriteChannelCell,
            let id = selectedCell.id {
            didSelectPodcast(id: id)
        }
    }
}
}

extension FavoritesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80
  }
}

// MARK: - setup constraints
extension FavoritesViewController {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
          titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            favouriteChanelsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            favouriteChanelsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            favouriteChanelsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favouriteChanelsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

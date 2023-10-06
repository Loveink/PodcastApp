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
//        tableView.backgroundColor = .red.withAlphaComponent(0.5)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
// MARK: - private properties
    var favouriteChanels: [PodcastItemCell] = []
//    private var favouriteChanels = ChannelModel.makeMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.setupTableView()
        self.setupNavigationBar()
      loadPodcastDataFromCoreData()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadPodcastDataFromCoreData()
  }

// MARK: - Private methodes
    
    private func setupView() {
        view.backgroundColor = .white
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
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
                      author: "",
                      categories: ["": ""]
                  )
              }
            
              favouriteChanelsTableView.reloadData()
          } catch {
              print("Ошибка при загрузке данных из Core Data: \(error)")
          }
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
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - setup constraints
extension FavoritesViewController {
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            favouriteChanelsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favouriteChanelsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favouriteChanelsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favouriteChanelsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

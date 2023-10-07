//
//  SaveToCoreData.swift
//  PodcastApp
//
//  Created by Александра Савчук on 02.10.2023.
//

import CoreData
import UIKit

struct SaveToCoreData {

  static func savePodcastInfoToCoreData(_ image: String, _ title: String, _ id: Int)  {
    var context: NSManagedObjectContext!
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    context = appDelegate.persistentContainer.viewContext

    let fetchRequest: NSFetchRequest<PodcastSave> = PodcastSave.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

    do {
      let existingPodcast = try context.fetch(fetchRequest).first
      if existingPodcast != nil {
        print("Подкаст с id \(id) уже существует в Core Data")
        return
      }
    } catch {
      print("Ошибка при проверке наличия подкаста: \(error)")
      return
    }

    let podcastSave = PodcastSave(context: context)
    podcastSave.title = title
    podcastSave.id = Int64(id)
    podcastSave.image = image

    do {
      try context.save()
      print("Подкаст успешно сохранен")
    } catch {
      print("Ошибка при сохранении подкаста: \(error)")
    }
  }

  static func saveRecentArrayToCoreData(_ image: String, _ title: String, _ id: Int, _ author: String, _ category: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let context = appDelegate.persistentContainer.viewContext

    let fetchRequest: NSFetchRequest<RecentPodcast> = RecentPodcast.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %ld", id)

    do {
      let existingPodcasts = try context.fetch(fetchRequest)
      if let existingPodcast = existingPodcasts.first {
        // Podcast with the same ID already exists in Core Data
        print("Podcast with ID \(id) already exists in Core Data")
        return
      }
    } catch {
      print("Error checking for existing podcast: \(error)")
      return
    }

    let podcastSave = RecentPodcast(context: context)
    podcastSave.title = title
    podcastSave.id = Int64(id)
    podcastSave.image = image
    podcastSave.author = author
    podcastSave.category = ["": category] as NSObject

    do {
      try context.save()
      print("Podcast successfully saved to Core Data")
    } catch {
      print("Error saving podcast: \(error)")
    }
  }
}

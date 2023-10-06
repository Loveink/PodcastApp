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
}

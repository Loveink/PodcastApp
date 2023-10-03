//
//  SaveToCoreData.swift
//  PodcastApp
//
//  Created by Александра Савчук on 02.10.2023.
//

import CoreData
import UIKit

struct SaveToCoreData {

  static func saveRecipeInfoToCoreData(_ image: String, _ title: String, _ id: Int)  {
    var context: NSManagedObjectContext!
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    context = appDelegate.persistentContainer.viewContext
    let PodcastSave = PodcastSave(context: context)
    PodcastSave.title = title
    PodcastSave.id = Int64(id)
    PodcastSave.image = image
      do {
        try context.save()
        print("Подкаст успешно сохранен")
      } catch {
        print("Ошибка: \(error)")
      }
    }
  }

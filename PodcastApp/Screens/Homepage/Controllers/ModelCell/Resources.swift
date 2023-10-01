//
//  Resouces.swift
//  WorkoutApp
//
//  Created by Максим Нурутдинов on 28.09.2023.
//

import UIKit
import Foundation

struct Item {
    let title: String
}

// Создайте структуру для представления данных из JSON
//struct MyData: Codable {
//    let objectId: String
//    // Добавьте другие свойства, если они есть в вашем JSON
//}



enum R {
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")
        static let separator = UIColor(hexString: "#E8ECEF")

        static let background = UIColor(hexString: "#FFFFFF")

        static let foreground = UIColor(hexString: "#FFFFFF").withAlphaComponent(0.3)
        static let titleGray = UIColor(hexString: "#545C77")
        static let cellBackground = UIColor(hexString: "#EDF0FC")
        
        static let heartDone = UIColor(hexString: "#F44336")
        static let heartNotDone = UIColor(hexString: "#BFC6CC")
        static let imagePink = UIColor(hexString: "#FED9D6")
    }

    enum Images {
        enum Overview {
            static let heartImage = UIImage(systemName: "heart")
            static let imagePink = UIImage(named: "FED9D6")
            static let imageWhite = UIImage(named: "FFFFFF")
            static let imageBlue = UIImage(named: "97D7F2")
        }
    }
    
    enum Fonts {
        static func helvelticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
}

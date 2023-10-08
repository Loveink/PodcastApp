//
//  CategoryItemCell.swift
//  PodcastApp
//
//  Created by Александра Савчук on 04.10.2023.
//

import UIKit

public let categoryDictionary: [String: String] = [
    "Arts & Books": "Arts,Books",
    "Fashion & Home": "Fashion,Beauty,Food,Home,Garden,Hobbies",
    "Business & Career": "Business,Careers,Entrepreneurship,Investing,Management,Marketing",
    "Education & Learning": "Education,Courses,How-To,Language,Learning,Self-Improvement",
    "Entertainment": "Comedy,Interviews,Improv,Stand-Up",
    "Family & Parenting": "Kids,Family,Parenting",
    "Health & Wellness": "Health,Fitness,Alternative,Medicine,Mental,Nutrition,Sexuality",
    "Fiction & Drama": "Fiction,Drama",
    "History & Culture": "History,Culture",
    "Science & Nature": "Science,Astronomy,Chemistry,Earth,Life,Mathematics,Natural,Nature,Physics",
    "Society & Social": "Social,Society",
    "Religion & Spirituality": "Buddhism,Christianity,Hinduism,Islam,Judaism,Religion,Spirituality",
    "Technology & Gadgets": "Technology,Cryptocurrency",
    "News & Politics": "News,Daily,Government,Politics",
    "Music & Commentary": "Music,Commentary",
    "Sports & Athletics": "Sports,Baseball,Basketball,Cricket,Fantasy,Football,Golf,Hockey,Rugby,Running,Soccer,Swimming,Tennis,Volleyball,Wrestling",
    "TV & Film": "TV,Film,After-Shows,Reviews",
    "Games & Gaming": "Games,Tabletop,Role-Playing"
]

struct CategoryInfoForCell {
    let categoryName: String
    let episodeCount: Int
    var categoryImage: UIImage? {
        return UIImage(named: categoryName)
    }

    init(categoryName: String, episodeCount: Int) {
        self.categoryName = categoryName
        self.episodeCount = episodeCount
    }
}

//
// Created by Kamel on 02/06/2023.
//

import Foundation

struct GamesResponse: Codable {
    let next: String?
    let previous: String?
    let results: [GameItemResponse]?
    let seoTitle: String?
    let seoDescription: String?
    let seoKeywords: String?
    let seoH1: String?
    let noindex: Bool?
    let nofollow: Bool?
    let description: String?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case next = "next"
        case previous = "previous"
        case results = "results"
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex = "noindex"
        case nofollow = "nofollow"
        case description = "description"
        case nofollowCollections = "nofollow_collections"
    }
}

struct GameItemResponse: Codable {
    let id: Int
    let name: String
    let backgroundImage: String
    let metacritic: Int?
    let genres: [Genre]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case backgroundImage = "background_image"
        case metacritic = "metacritic"
        case genres = "genres"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
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

struct AddedByStatus: Codable {
    let yet: Int
    let owned: Int
    let beaten: Int
    let toplay: Int
    let dropped: Int
    let playing: Int

    enum CodingKeys: String, CodingKey {
        case yet = "yet"
        case owned = "owned"
        case beaten = "beaten"
        case toplay = "toplay"
        case dropped = "dropped"
        case playing = "playing"
    }
}

enum GameColor: String, Codable {
    case the0F0F0F = "0f0f0f"
}

struct EsrbRating: Codable {
    let id: Int
    let name: String
    let slug: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: String?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain = "domain"
        case language = "language"
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

struct ParentPlatform: Codable {
    let platform: EsrbRating

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
    }
}

struct PlatformItemResponse: Codable {
    let platform: Platform
    let releasedAt: String?
    let requirementsEn: Requirements?
    let requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

struct Platform: Codable {
    let id: Int
    let name: String
    let slug: String
    let yearEnd: Int?
    let yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct Requirements: Codable {
    let minimum: String
    let recommended: String?

    enum CodingKeys: String, CodingKey {
        case minimum = "minimum"
        case recommended = "recommended"
    }
}

struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case count = "count"
        case percent = "percent"
    }
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

struct ShortScreenshot: Codable {
    let id: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
    }
}

struct Store: Codable {
    let id: Int
    let store: Genre

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case store = "store"
    }
}
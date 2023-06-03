//
// Created by Kamel on 02/06/2023.
//

import Foundation

struct GameItem: Identifiable {
    let id: Int
    let name: String
    let backgroundImage: String
    let metacritic: Int
    let genres: [Genre]
    let response: GameItemResponse

    var genresDescription: String {
        genres.map {
                    $0.name
                }
                .joined(separator: ", ")
    }
}

struct GameItemsResponse {
    let next: String?
    let previous: String?
    let results: [GameItem]
    let seoTitle: String
    let seoDescription: String
    let seoKeywords: String
    let seoH1: String
    let noindex: Bool
    let nofollow: Bool
    let description: String
    let nofollowCollections: [String]
}

struct GameItemMapper {

    static func map(_ input: GamesResponse) -> GameItemsResponse {
        GameItemsResponse(
                next: input.next,
                previous: input.previous ?? "",
                results: map(input.results ?? []),
                seoTitle: input.seoTitle ?? "",
                seoDescription: input.seoDescription ?? "",
                seoKeywords: input.seoKeywords ?? "",
                seoH1: input.seoH1 ?? "",
                noindex: input.noindex ?? false,
                nofollow: input.nofollow ?? false,
                description: input.description ?? "",
                nofollowCollections: input.nofollowCollections ?? [])
    }

    static func map(_ input: [GameItemResponse]) -> [GameItem] {
        input.map {
            map($0)
        }
    }

    static func map(_ input: GameItemResponse) -> GameItem {
        GameItem(
                id: input.id,
                name: input.name,
                backgroundImage: input.backgroundImage,
                metacritic: input.metacritic ?? 0,
                genres: input.genres,
                response: input
        )
    }

}
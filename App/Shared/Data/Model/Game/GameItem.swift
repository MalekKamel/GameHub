//
// Created by Kamel on 02/06/2023.
//

import Foundation

struct GameItem: Identifiable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount: Int
    let reviewsTextCount: Int
    let added: Int
    let addedByStatus: AddedByStatus
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
    let reviewsCount: Int
    let saturatedColor: GameColor
    let dominantColor: GameColor
    let platforms: [PlatformItemResponse]
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let stores: [Store]
    let tags: [Genre]
    let esrbRating: EsrbRating
    let shortScreenshots: [ShortScreenshot]
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
        let items = input.results?
                .map {
                    map($0)
                } ?? []
        return GameItemsResponse(
                next: input.next,
                previous: input.previous ?? "",
                results: items,
                seoTitle: input.seoTitle ?? "",
                seoDescription: input.seoDescription ?? "",
                seoKeywords: input.seoKeywords ?? "",
                seoH1: input.seoH1 ?? "",
                noindex: input.noindex ?? false,
                nofollow: input.nofollow ?? false,
                description: input.description ?? "",
                nofollowCollections: input.nofollowCollections ?? [])
    }

    static func map(_ input: GameItemResponse) -> GameItem {
        GameItem(
                id: input.id,
                slug: input.slug,
                name: input.name,
                released: input.released,
                tba: input.tba,
                backgroundImage: input.backgroundImage,
                rating: input.rating,
                ratingTop: input.ratingTop,
                ratings: input.ratings,
                ratingsCount: input.ratingsCount,
                reviewsTextCount: input.reviewsTextCount,
                added: input.added,
                addedByStatus: input.addedByStatus,
                metacritic: input.metacritic,
                playtime: input.playtime,
                suggestionsCount: input.suggestionsCount,
                updated: input.updated,
                reviewsCount: input.reviewsCount,
                saturatedColor: input.saturatedColor,
                dominantColor: input.dominantColor,
                platforms: input.platforms,
                parentPlatforms: input.parentPlatforms,
                genres: input.genres,
                stores: input.stores,
                tags: input.tags,
                esrbRating: input.esrbRating,
                shortScreenshots: input.shortScreenshots
        )
    }

}
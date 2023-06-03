//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesLocalDataSrcContract {
    func lastGameResponse() async throws -> GamesResponse?
    func games() async throws -> [GameItemResponse]
    func cache(gamesResponse: GamesResponse) async throws
    func clearCache() async throws
    func updateFavorite(item: GameItemResponse) async throws -> Bool
    func favorites() async throws -> [GameItemResponse]
}

struct GamesLocalDataSrc: GamesLocalDataSrcContract {
    private let cacheManager: CacheManagerContract

    public init(cacheManager: CacheManagerContract = AppCacheManager.shared) {
        self.cacheManager = cacheManager
    }

    func lastGameResponse() async throws -> GamesResponse? {
        await cacheManager.get(.gamesResponse)
    }

    func games() async throws -> [GameItemResponse] {
        await cacheManager.array(.games)
    }

    func cache(gamesResponse: GamesResponse) async throws {
        try await cacheManager.save(gamesResponse, .gamesResponse, expiry: nil)
        try await cacheManager.append(gamesResponse.results ?? [], .games)
    }

    func clearCache() async throws {
        await cacheManager.remove(.games)
        await cacheManager.remove(.gamesResponse)
    }

    func updateFavorite(item: GameItemResponse) async throws -> Bool {
        let items: [GameItemResponse] = await cacheManager.array(.favoriteGames)
        let isFavorite = items.contains {
            $0.id == item.id
        }

        guard !isFavorite else {
            let updated = items.filter {
                $0.id != item.id
            }
            try await cacheManager.save(updated, .favoriteGames, expiry: nil)
            return false
        }

        try await cacheManager.append(item, .favoriteGames)
        return true
    }

    func favorites() async throws -> [GameItemResponse] {
        await cacheManager.array(.favoriteGames)
    }
}

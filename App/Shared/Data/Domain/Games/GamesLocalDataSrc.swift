//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesLocalDataSrcContract {
    func games() async throws -> GamesResponse?
    func cache(games: GamesResponse) async throws
}

struct GamesLocalDataSrc: GamesLocalDataSrcContract {
    private let cacheManager: CacheManagerContract

    public init(cacheManager: CacheManagerContract = AppCacheManager.shared) {
        self.cacheManager = cacheManager
    }

    func games() async throws -> GamesResponse? {
        await cacheManager.get(.games)
    }

    func cache(games: GamesResponse) async throws {
        try await cacheManager.save(games, .games, expiry: nil)
    }
}

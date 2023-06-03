//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesLocalDataSrcContract {
    func lastGameResponse() async throws -> GamesResponse?
    func games() async throws -> [GameItemResponse]
    func cache(gamesResponse: GamesResponse) async throws
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
}

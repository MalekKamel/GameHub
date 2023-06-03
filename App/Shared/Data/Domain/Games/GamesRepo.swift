//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesRepoContract {
    func games(request: GamesRequest) async throws -> GamesResponse?
    func clearCache() async throws
    func updateFavorite(item: GameItemResponse) async throws -> Bool
    func favorites() async throws -> [GameItemResponse]
}

struct GamesRepo: GamesRepoContract {
    static let shared = GamesRepo.build()
    private let remote: GamesRemoteDataSrcContract
    private let local: GamesLocalDataSrcContract
    private let userDefaults: AppUserDefaultsContract

    init(
            remote: GamesRemoteDataSrcContract,
            local: GamesLocalDataSrcContract,
            userDefaults: AppUserDefaultsContract) {
        self.remote = remote
        self.local = local
        self.userDefaults = userDefaults
    }

    func games(request: GamesRequest) async throws -> GamesResponse? {
        switch request {
        case .initial:
            let localItems = try await local.games()
            guard localItems.isEmpty else {
                return try await local.lastGameResponse()
            }
        case .next:
            break
        }
        let response = try await remote.games(request: request)
        try await local.cache(gamesResponse: response)
        return response
    }

    func clearCache() async throws {
        try await local.clearCache()
    }

    func updateFavorite(item: GameItemResponse) async throws -> Bool {
        try await local.updateFavorite(item: item)
    }

    func favorites() async throws -> [GameItemResponse] {
        try await local.favorites()
    }

}

extension GamesRepo {

    static func build() -> GamesRepo {
        let remote = GamesRemoteDataSrc(api: GamesApiProvider.create())
        let local = GamesLocalDataSrc()
        return GamesRepo(remote: remote, local: local, userDefaults: AppUserDefaults.shared)
    }
}

//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesRepoContract {
    func games(request: GamesRequest) async throws
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

    func games(request: GamesRequest) async throws {
        let localItems = try await local.games()
        if localItems != nil, localItems?.results?.isEmpty == false {
            return
        }
        let response = try await remote.games(request: request)
        try await local.cache(games: response)
    }
}

extension GamesRepo {

    static func build() -> GamesRepo {
        let remote = GamesRemoteDataSrc(api: GamesApiProvider.create())
        let local = GamesLocalDataSrc()
        return GamesRepo(remote: remote, local: local, userDefaults: AppUserDefaults.shared)
    }
}

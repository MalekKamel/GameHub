//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol GamesRemoteDataSrcContract {
    func games(request: GamesRequest) async throws -> GamesResponse
}

struct GamesRemoteDataSrc: GamesRemoteDataSrcContract {
    private let api: GamesApiProvider

    init(api: GamesApiProvider) {
        self.api = api
    }

    func games(request: GamesRequest) async throws -> GamesResponse {
        try await api.request(target: .games(request))
    }

    func cache(games: GamesResponse) async throws {

    }
}

//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class GamesRemoteDataSrcMock: GamesRemoteDataSrcContract {
    var shouldThrowError = false
    var gamesCalled = false
    var gamesResponse = GamesResponse(
            next: "2",
            previous: "",
            results: [],
            seoTitle: "",
            seoDescription: "",
            seoKeywords: "",
            seoH1: "",
            noindex: false,
            nofollow: false,
            description: "",
            nofollowCollections: []
    )

    func games(request: GamesRequest) async throws -> GamesResponse {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        gamesCalled = true
        return gamesResponse
    }
}
//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class GamesLocalDataSrcMock: GamesLocalDataSrcContract {
    var shouldThrowError = false
    var lastGameResponseValue: GamesResponse?
    var gamesValue: [GameItemResponse] = []
    var cacheValue: GamesResponse?
    var clearCacheCalled = false
    var updateFavoriteReturnValue = false
    var favoritesValue: [GameItemResponse] = []

    func lastGameResponse() async throws -> GamesResponse? {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return lastGameResponseValue
    }

    func games() async throws -> [GameItemResponse] {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return gamesValue
    }

    func cache(gamesResponse: GamesResponse) async throws {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        cacheValue = gamesResponse
    }

    func clearCache() async throws {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        clearCacheCalled = true
    }

    func updateFavorite(item: GameItemResponse) async throws -> Bool {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return updateFavoriteReturnValue
    }

    func favorites() async throws -> [GameItemResponse] {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return favoritesValue
    }
}

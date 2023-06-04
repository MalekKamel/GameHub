//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class GamesLocalDataSrcMock: GamesLocalDataSrcContract {
    var shouldThrowError = false
    var lastGameResponseValue: GamesResponse?
    var gamesValue: [GameItemResponse] = []
    var gamesCalled: Bool = false
    var cacheValue: GamesResponse?
    var clearCacheCalled = false
    var updateFavoriteReturnValue = false
    var favoritesValue: [GameItemResponse] = []
    var updateFavoriteCalled = false

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
        gamesCalled = true
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
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        updateFavoriteCalled = true
        // In the mock implementation, we just check if the item is already in the array of favorite games
        let isAdded = !favoritesValue.contains(where: { $0.id == item.id })
        if isAdded {
            favoritesValue.append(item)
        } else {
            favoritesValue.removeAll(where: { $0.id == item.id })
        }
        return isAdded
    }

    func favorites() async throws -> [GameItemResponse] {
        if shouldThrowError {
            throw NSError(domain: "", code: 0, userInfo: nil)
        }
        return favoritesValue
    }
}

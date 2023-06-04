//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class GamesRepoMock: GamesRepoContract {
    var shouldThrowError = false
    var gamesResponse: GamesResponse?
    var favoriteGames: [GameItemResponse] = []
    var gamesCalled = false
    var clearCacheCalled = false
    var updateFavoriteCalled = false
    var favoritesCalled = false
    var gamesRequest: GamesRequest? = nil
    var gameItemResponse: GameItemResponse? = nil

    func games(request: GamesRequest) async throws -> GamesResponse? {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        gamesRequest = request
        gamesCalled = true
        return gamesResponse
    }

    func clearCache() async throws {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        clearCacheCalled = true
    }

    func updateFavorite(item: GameItemResponse) async throws -> Bool {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        gameItemResponse = item
        updateFavoriteCalled = true
        // In the mock implementation, we just check if the item is already in the array of favorite games
        let isAdded = !favoriteGames.contains(where: { $0.id == item.id })
        if isAdded {
            favoriteGames.append(item)
        } else {
            favoriteGames.removeAll(where: { $0.id == item.id })
        }
        return isAdded
    }

    func favorites() async throws -> [GameItemResponse] {
        if shouldThrowError {
            throw NSError(domain: "Mock Error", code: 0, userInfo: nil)
        }
        favoritesCalled = true
        return favoriteGames
    }

}

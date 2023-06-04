//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class FavoritesVMTests: XCTestCase {
    var favoritesVM: FavoritesVM!

    var requester: AsyncManMock!
    var gamesRepo: GamesRepoMock!
    var cacheManager: CacheManagerMock!

    override func setUp() {
        super.setUp()
        requester = AsyncManMock()
        gamesRepo = GamesRepoMock()
        cacheManager = CacheManagerMock()
        favoritesVM = FavoritesVM(
                requester: requester,
                gamesRepo: gamesRepo,
                cacheManager: cacheManager
        )
    }

    override func tearDown() {
        favoritesVM = nil
        requester = nil
        gamesRepo = nil
        cacheManager = nil
        super.tearDown()
    }

    func testLoadGamesWithEmptyKey() {
        // When
        favoritesVM.loadGames()

        // Then
        runAsyncTest {
            XCTAssertTrue(self.gamesRepo.favoritesCalled)
        }
    }

    func testUpdateFavorite_shouldRemove() {
        // Given
        let item = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])

        gamesRepo.favoriteGames = [item]
        favoritesVM.updateFavorite(item: item) {
        }
        // Then
        runAsyncTest {
            XCTAssertTrue(self.gamesRepo.favoriteGames.isEmpty)
        }
    }

}
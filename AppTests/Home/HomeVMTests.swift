//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class HomeVMTests: XCTestCase {
    var homeVM: HomeVM!

    var requester: AsyncManMock!
    var gamesRepo: GamesRepoMock!
    var cacheManager: CacheManagerMock!

    override func setUp() {
        super.setUp()
        requester = AsyncManMock()
        gamesRepo = GamesRepoMock()
        cacheManager = CacheManagerMock()
        homeVM = HomeVM(
                requester: requester,
                gamesRepo: gamesRepo,
                cacheManager: cacheManager
        )
    }

    override func tearDown() {
        homeVM = nil
        requester = nil
        gamesRepo = nil
        cacheManager = nil
        super.tearDown()
    }

    func testSearchGamesWithEmptyKey() {
        // Given
        homeVM.search = ""

        // When
        homeVM.searchGames()

        // Then
        XCTAssertFalse(gamesRepo.gamesCalled)
    }

    func testSearchGamesWithBlankKey() {
        // Given
        homeVM.search = "  "

        // When
        homeVM.searchGames()

        // Then
        XCTAssertFalse(gamesRepo.gamesCalled)
    }

    func testSearchGamesWithNonEmptyKey() {
        // Given
        homeVM.search = "zelda"

        // When
        homeVM.searchGames()

        // Then
        runAsyncTest {
            XCTAssertTrue(self.gamesRepo.gamesCalled)
        }
    }

    func testLoadNextGamesWithNoNextPage() {
        // Given
        homeVM.lastGameResponse = nil

        // When
        homeVM.loadNextGames()

        // Then
        runAsyncTest {
            XCTAssertFalse(self.gamesRepo.gamesCalled)
        }
    }

    func testLoadNextGamesWithNextPage() {
        // Given
        homeVM.lastGameResponse = GamesResponse(
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

        // When
        homeVM.loadNextGames()

        // Then
        runAsyncTest {
            XCTAssertTrue(self.gamesRepo.gamesCalled)
        }
    }

    func testUpdateFavorite_shouldAdd() {
        // Given
        let item = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])

        var added = false
        // When
        homeVM.updateFavorite(item: item) { isAdded in
            // Then
            added = isAdded
        }
        runAsyncTest {
            XCTAssertTrue(added)
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
        var added = true
        // When
        homeVM.updateFavorite(item: item) { isAdded in
            added = isAdded
        }
        // Then
        runAsyncTest {
            XCTAssertFalse(added)
        }
    }

}
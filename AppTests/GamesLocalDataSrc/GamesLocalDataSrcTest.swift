//
// Created by Kamel on 30/05/2023.
//

import XCTest
@testable import App

class GamesLocalDataSrcTest: XCTestCase {
    var cacheManager: CacheManagerMock!
    var subject: GamesLocalDataSrc!

    override func setUp() {
        super.setUp()
        cacheManager = CacheManagerMock()
        subject = GamesLocalDataSrc(cacheManager: cacheManager)
    }

    override func tearDown() {
        cacheManager = nil
        subject = nil
        super.tearDown()
    }

    func testLastGameResponse() {
        // Given
        let gamesResponse = GamesResponse(
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

        cacheManager.getReturnValue = gamesResponse

        runAsyncTest { [self] in
            // When
            let result = try await subject.lastGameResponse()
            // Then
            XCTAssertEqual(result?.next, gamesResponse.next)
        }
    }

    func testGames() {
        // Given
        let gameItemResponse1 = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])
        let gameItemResponse2 = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])
        let gameItemResponseArray = [gameItemResponse1, gameItemResponse2]

        cacheManager.arrayReturnValue = gameItemResponseArray

        runAsyncTest { [self] in
            // When
            let result = try await subject.games()
            // Then
            XCTAssertEqual(result.count, gameItemResponseArray.count)
        }
    }

    func testCache() {
        // Given
        let gamesResponse = GamesResponse(
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

        runAsyncTest { [self] in
            // When
            try await subject.cache(gamesResponse: gamesResponse)

            // Then
            XCTAssertTrue(cacheManager.saveCalled)
            XCTAssertTrue(cacheManager.appendCalled)
        }
    }

    func testClearCache() {
        runAsyncTest { [self] in
            try await subject.clearCache()
            XCTAssertTrue(cacheManager.removeCalled)
        }
    }

    func testUpdateFavorite() {
        cacheManager.arrayReturnValue = []
        // Given
        let gameItemResponse = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])

        runAsyncTest { [self] in
            // When
            let result1 = try await subject.updateFavorite(item: gameItemResponse)

            // When
            cacheManager.arrayReturnValue = [gameItemResponse]
            let result2 = try await subject.updateFavorite(item: gameItemResponse)

            // Then
            XCTAssertTrue(result1)
            XCTAssertFalse(result2)
        }
    }

    func testFavorites() {
        let gameItemResponse1 = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])
        let gameItemResponse2 = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])
        let gameItemResponseArray = [gameItemResponse1, gameItemResponse2]

        // Given
        cacheManager.arrayReturnValue = gameItemResponseArray

        runAsyncTest { [self] in
            // When
            let result = try await subject.favorites()

            // Then
            XCTAssertEqual(result.count, gameItemResponseArray.count)
        }
    }
}
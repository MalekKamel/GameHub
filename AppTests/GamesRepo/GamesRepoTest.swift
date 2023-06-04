//
//  GamesRepoTest.swift
//  AppTests
//
//  Created by Kamel on 30/05/2023.
//

import XCTest
@testable import App

class GamesRepoTest: XCTestCase {
    var remote: GamesRemoteDataSrcMock!
    var local: GamesLocalDataSrcMock!
    var defaults: AppUserDefaultsMock!
    var gamesRepo: GamesRepo!

    override func setUp() {
        super.setUp()
        remote = GamesRemoteDataSrcMock()
        local = GamesLocalDataSrcMock()
        defaults = AppUserDefaultsMock()
        gamesRepo = GamesRepo(
                remote: remote,
                local: local,
                userDefaults: defaults
        )
    }

    func testGamesInitialEmptyLocalResponse() {
        // Given
        let expectedResponse = GamesResponse(
                next: "",
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
        remote.gamesResponse = expectedResponse

        // Given
        local.gamesValue = []
        local.lastGameResponseValue = nil

        runAsyncTest { [self] in
            // When
            _ = try await gamesRepo.games(request: .initial())

            // Then
            XCTAssertTrue(local.gamesCalled)
        }
    }

    func testGamesInitialNonEmptyLocalResponse() {
        // Given
        let expectedResponse = GamesResponse(
                next: "",
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
        local.lastGameResponseValue = expectedResponse

        runAsyncTest { [self] in
            // When
            _ = try await gamesRepo.games(request: .initial())

            // Then
            XCTAssertTrue(local.gamesCalled)
        }
    }

    func testGamesNextResponse() {
        // Given
        let expectedResponse = GamesResponse(
                next: "",
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
        local.lastGameResponseValue = expectedResponse

        runAsyncTest { [self] in
            // When
            _ = try await gamesRepo.games(request: .next(page: ""))

            // Then
            XCTAssertTrue(remote.gamesCalled)
        }
    }

    func testClearCache() {
        runAsyncTest { [self] in
            // When
            try await gamesRepo.clearCache()

            // Then
            XCTAssertTrue(local.clearCacheCalled)
        }
    }

    func testUpdateFavorite() {
        // Given
        let gameItemResponse = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])

        local.favoritesValue = [gameItemResponse]

        runAsyncTest { [self] in
            // When
            let result1 = try await gamesRepo.updateFavorite(item: gameItemResponse)
            XCTAssertFalse(result1)

            // Then
            XCTAssertTrue(local.favoritesValue.isEmpty)

            // When
            let result2 = try await gamesRepo.updateFavorite(item: gameItemResponse)
            XCTAssertTrue(result2)

            // Then
            XCTAssertFalse(local.favoritesValue.isEmpty)
        }
    }

    func testFavorites() {
        let gameItemResponse = GameItemResponse(
                id: 1,
                name: "Test Game",
                backgroundImage: nil,
                metacritic: nil,
                genres: [])
        // Given
        let expectedFavorites = [gameItemResponse]
        local.favoritesValue = expectedFavorites

        runAsyncTest { [self] in
            // When
            let result = try await gamesRepo.favorites()
            // Then
            XCTAssertEqual(result.count, expectedFavorites.count)
        }
    }
}
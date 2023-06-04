//
// Created by Kamel on 30/05/2023.
//

import XCTest
@testable import App
@testable import Moya

class GamesRemoteDataSrcTest: XCTestCase {
    var apiProvider: GamesApiProvider!
    var subject: GamesRemoteDataSrc!

    override func setUp() {
        super.setUp()
        apiProvider = MoyaProvider<GamesApi>(stubClosure: MoyaProvider.immediatelyStub)
        subject = GamesRemoteDataSrc(api: apiProvider)
    }

    override func tearDown() {
        apiProvider = nil
        subject = nil
        super.tearDown()
    }

    func testGames() async throws {
        // Given
        let gamesRequest = GamesRequest.initial()

        // When
        let result = try await subject.games(request: gamesRequest)

        let expectedGamesResponse = GamesResponse(
                next: "https://api.rawg.io/api/games?key=3be8af6ebf124ffe81d90f514e59856c&page=2&page_size=10",
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

        // Then
        XCTAssertEqual(result.next, expectedGamesResponse.next)
    }
}
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
}
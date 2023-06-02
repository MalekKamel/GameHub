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
}
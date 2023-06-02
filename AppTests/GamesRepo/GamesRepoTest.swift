//
//  GamesRepoTest.swift
//  AppTests
//
//  Created by Kamel on 30/05/2023.
//

import XCTest
@testable import App

class GamesRepoTest: XCTestCase {
    var subject: GamesRepoContract!
    var remoteDataSourceMock: GamesRemoteDataSrcMock!
    var localDataSourceMock: GamesLocalDataSrcMock!
    var userDefaultsMock: AppUserDefaultsMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        remoteDataSourceMock = GamesRemoteDataSrcMock()
        localDataSourceMock = GamesLocalDataSrcMock()
        userDefaultsMock = AppUserDefaultsMock()
        subject = GamesRepo(
                remote: remoteDataSourceMock,
                local: localDataSourceMock,
                userDefaults: userDefaultsMock
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        remoteDataSourceMock = nil
        localDataSourceMock = nil
        userDefaultsMock = nil
        subject = nil
    }
}
//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

public protocol GamesRemoteDataSrcContract {
}

public struct GamesRemoteDataSrc: GamesRemoteDataSrcContract {
    private let api: GamesApiProvider

    init(api: GamesApiProvider) {
        self.api = api
    }

}

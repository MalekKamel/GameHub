//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

public protocol GamesLocalDataSrcContract {
}

public struct GamesLocalDataSrc: GamesLocalDataSrcContract {
    private let cacheManager: CacheManagerContract

    public init(cacheManager: CacheManagerContract = AppCacheManager.shared) {
        self.cacheManager = cacheManager
    }

}

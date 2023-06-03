//
// Created by Kamel on 29/05/2023.
//

import Foundation

class MainVM: AppViewModel {
    var requester: AsyncManContract

    let gamesRepo: GamesRepoContract
    private var cacheManager: CacheManagerContract
    private var cacheBag = CacheBag()

    let screens = MainTabScreens()

    @Published var selectedTab: MainTabKey? = nil

    init(requester: AsyncManContract = AsyncMan(),
         gamesRepo: GamesRepoContract = GamesRepo.build(),
         cacheManager: CacheManagerContract = AppCacheManager.shared) {
        self.requester = requester
        self.gamesRepo = gamesRepo
        self.cacheManager = cacheManager
    }

    deinit {
        cacheBag.dispose()
    }

}
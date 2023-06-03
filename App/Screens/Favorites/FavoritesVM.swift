//
// Created by Kamel on 29/05/2023.
//

import Foundation

class FavoritesVM: AppViewModel {
    var requester: AsyncManContract

    let gamesRepo: GamesRepoContract
    private var cacheManager: CacheManagerContract
    private var cacheBag = CacheBag()

    @Published var games: [GameItem] = []

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

    func loadGames() {
        request { [weak self] in
            guard let self else {
                return
            }
            let response = try await self.gamesRepo.favorites()
            onMainThread {
                self.games = GameItemMapper.map(response)
            }
        }
    }

    func updateFavorite(item: GameItemResponse, completion: @escaping () -> Void) {
        request { [weak self] in
            guard let self else {
                return
            }

            _ = try await self.gamesRepo.updateFavorite(item: item)
            onMainThread(completion)
            self.loadGames()
        }
    }

}

//
// Created by Kamel on 29/05/2023.
//

import Foundation

class HomeVM: AppViewModel {
    var requester: AsyncManContract

    let gamesRepo: GamesRepoContract
    private var cacheManager: CacheManagerContract
    private var cacheBag = CacheBag()

    @Published
    var search: String = ""

    @Published var gamesState: ListLoadingState<GameItem> = .empty
    @Published var canLoadNextPage = true
    var lastGameResponse: GamesResponse? = nil

    init(requester: AsyncManContract = AsyncMan(),
         gamesRepo: GamesRepoContract = GamesRepo.build(),
         cacheManager: CacheManagerContract = AppCacheManager.shared) {
        self.requester = requester
        self.gamesRepo = gamesRepo
        self.cacheManager = cacheManager
        setup()
    }

    deinit {
        cacheBag.dispose()
    }

    private func setup() {
        observeGames()
    }

    private func observeGames() {
        cacheManager.observe(
                        self,
                        type: [GameItemResponse].self,
                        key: .games
                ) { [weak self] value in
                    guard let self = self else {
                        return
                    }
                    guard let value else {
                        self.gamesState = .empty
                        return
                    }
                    let items = GameItemMapper.map(value)
                    self.gamesState = ListLoadingState<GameItem>.from(items)
                }?
                .dispose(with: cacheBag)
    }

    func searchGames() {
        let key = search.trimmingCharacters(in: .whitespaces)
        guard !key.isEmpty else {
            return
        }

        request { [weak self] in
            guard let self else {
                return
            }
            try await self.gamesRepo.clearCache()
            self.loadGames(request: .initial(search: key))
        }
    }

    func loadGames() {
        loadGames(request: .initial())
    }

    func loadNextGames() {
        guard let next = lastGameResponse?.next else {
            return
        }
        loadGames(request: .next(page: next))
    }

    func loadGames(request: GamesRequest) {
        self.request { [weak self] in
            guard let self else {
                return
            }
            let response = try await self.gamesRepo.games(request: request)
            onMainThread {
                self.lastGameResponse = response
            }
        }
    }

    func updateFavorite(item: GameItemResponse, completion: @escaping (Bool) -> Void) {
        request { [weak self] in
            guard let self else {
                return
            }

            let isAdded = try await self.gamesRepo.updateFavorite(item: item)
            onMainThread {
                completion(isAdded)
            }
        }
    }

}

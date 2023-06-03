//
// Created by Kamel on 15/03/2023.
//

import Foundation

public enum AppCacheKey: Hashable {
    case gamesResponse
    case games
    case favoriteGames
    case custom(String)

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

    var key: String {
        switch self {
        case .gamesResponse:
            return "games.response"
        case .games:
            return "games"
        case .favoriteGames:
            return "games.favorite"
        case .custom(let value):
            return value
        }
    }
}

public struct AppCacheCustomKey {

}

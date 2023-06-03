//
// Created by Kamel on 15/03/2023.
//

import Foundation

public enum AppCacheKey: Hashable {
    case games
    case custom(String)

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

    var key: String {
        switch self {
        case .games:
            return "games.response"
        case .custom(let value):
            return value
        }
    }
}

public struct AppCacheCustomKey {

}

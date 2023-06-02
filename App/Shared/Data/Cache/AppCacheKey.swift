//
// Created by Kamel on 15/03/2023.
//

import Foundation

public enum AppCacheKey: Hashable {
    case custom(String)

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }

    var key: String {
        switch self {
        case .custom(let value):
            return value
        }
    }
}

public struct AppCacheCustomKey {

}

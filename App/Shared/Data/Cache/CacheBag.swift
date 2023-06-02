//
// Created by Kamel on 21/03/2023.
//

import Foundation

class CacheBag {
    private var tokens: [AppCacheObservationToken] = []

    func add(_ token: AppCacheObservationToken?) {
        guard let token else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.tokens.append(token)
        }
    }

    func dispose() {
        for token in tokens {
            token.cancel()
        }
        tokens.removeAll()
    }
}

extension AppCacheObservationToken {
    func dispose(with bag: CacheBag) {
        bag.add(self)
    }
}
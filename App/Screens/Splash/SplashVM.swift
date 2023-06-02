//
// Created by Kamel on 29/05/2023.
//

import Foundation

class SplashVM: AppViewModel {
    var requester: AsyncManContract

    init(requester: AsyncManContract = AsyncMan()) {
        self.requester = requester
    }
}

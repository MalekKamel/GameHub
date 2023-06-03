//
// Created by Kamel on 29/05/2023.
//

import Foundation

class GameDetailVM: AppViewModel {
    var requester: AsyncManContract
    let game: GameItem

    init(game: GameItem, requester: AsyncManContract = AsyncMan()) {
        self.game = game
        self.requester = requester
    }

}
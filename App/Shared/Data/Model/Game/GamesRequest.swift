//
// Created by Shaban on 02/06/2023.
//

import Foundation

enum GamesRequest {
    case initial(pageSize: Int = 10, search: String = "")
    case next(page: String)
}

//
// Created by Kamel on 23/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Moya
import Foundation

typealias GamesApiProvider = MoyaProvider<GamesApi>

enum GamesApi {
}

extension GamesApi: MoyaTargetType {

    public var path: String {
       ""
    }

    public var method: Moya.Method {
        .get
    }

    public var task: Task {
        .requestPlain
    }
}
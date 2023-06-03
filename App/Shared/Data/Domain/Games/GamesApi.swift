//
// Created by Kamel on 23/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Moya
import Foundation

typealias GamesApiProvider = MoyaProvider<GamesApi>

enum GamesApi {
    case games(GamesRequest)
}

extension GamesApi: MoyaTargetType {

    public var baseURL: URL {
        switch self {
        case .games(let request):
            switch request {
            case .initial:
                return URL(string: AppEnvironment.shared.baseUrl)!
            case .next(let page):
                return URL(string: page)!
            }
        }
    }

    public var path: String {
        switch self {
        case .games(let request):
            switch request {
            case .initial:
                return "games"
            case .next:
                return ""
            }
        }
    }

    public var method: Moya.Method {
        switch self {
        case .games:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .games(let request):
            switch request {
            case let .initial(pageSize, search):
                var params = [
                    "page_size": pageSize.toString,
                    "key": AppPList.value(of: .gamesKey)
                ]
                if !search.isEmpty {
                    params["search"] = search
                }
                return .requestParameters(parameters: params, encoding: URLEncoding.default)
            case .next:
                return .requestPlain
            }
        }
    }
}
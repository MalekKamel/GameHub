//
//  MockDataPreviews.swift
//
//  Created by Kamel on 07/02/2023.
//

import Foundation


class Fake {
    static let shared = Fake()

    lazy var listItems: [ListItem] =
            [
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: "")
            ]

    lazy var gameItemResponse = GameItemResponse(
            id: 1,
            name: "Game",
            backgroundImage: "https://cdn.dribbble.com/users/1787323/screenshots/12057610/media/8e7e8e869bf389fb727ac393c42e6b27.png?compress=1&resize=1600x1200&vertical=top",
            metacritic: 20,
            genres: [Genre(id: 2, name: "Action")]
    )

    lazy var game = GameItem(
            id: 1,
            name: "Game",
            backgroundImage: "https://cdn.dribbble.com/users/1787323/screenshots/12057610/media/8e7e8e869bf389fb727ac393c42e6b27.png?compress=1&resize=1600x1200&vertical=top",
            metacritic: 20,
            genres: [Genre(id: 2, name: "Action")],
            response: gameItemResponse
    )
}

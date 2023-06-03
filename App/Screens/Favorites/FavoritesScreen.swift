//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct FavoritesScreen: AppScreen {
    @ObservedObject var vm: FavoritesVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        GamesView()
    }

    private func GamesView() -> some View {
        Group {
            if vm.games.isEmpty {
                ItemsPlaceholderView()
                        .infiniteSize()
            } else {
                GamesList()
            }
        }
    }

    private func GamesList() -> some View {
        List {
            ForEach(vm.games) { item in
                ItemView(item: item)
            }
                    .onDelete(perform: delete)
        }
                .listStyle(.plain)
    }

    private func ItemView(item: GameItem) -> some View {
        GameItemView(item: item, canFavorite: false)
    }

    private func ItemsPlaceholderView() -> some View {
        GamesPlaceholderView(description: Strings.yourFavoritesListIsEmptyAtTheMoment)
    }

}

extension FavoritesScreen {

    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        let item = vm.games[index]
        vm.games.remove(atOffsets: offsets)
        updateFavorite(item: item)
    }

}

extension FavoritesScreen {

    func onAppear() {
        vm.loadGames()
    }

}

extension FavoritesScreen {

    private func updateFavorite(item: GameItem) {
        vm.updateFavorite(item: item.response) {
            let message = Strings.youHaveSuccessfullyRemovedThisItemFromYourListOfFavorites
            showSuccess(message: message)
        }
    }

}

extension FavoritesScreen {

    static func build() -> some View {
        let vm = FavoritesVM()
        return FavoritesScreen(vm: vm)
    }

}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen.build()
    }
}




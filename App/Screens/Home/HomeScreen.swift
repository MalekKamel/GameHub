//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct HomeScreen: AppScreen {
    @ObservedObject var vm: HomeVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        VStack(alignment: .center, spacing: 16) {
            SearchFieldView()
            GamesView()
                    .infiniteHeight()
        }
                .padding(.horizontal, 22)
    }

    private func SearchFieldView() -> some View {
        SearchField(
                title: Strings.findNextGame,
                text: $vm.search
        ) {
            searchGames()
        }
    }

    private func GamesView() -> some View {
        PagedList(
                vm.gamesState,
                hasMoreItems: vm.canLoadNextPage,
                loadMore: {
                    vm.loadNextGames()
                },
                emptyContent: {
                    ItemsPlaceholderView()
                }
        ) { item in
            ItemView(item: item)
        }
    }

    private func ItemView(item: GameItem) -> some View {
        GameItemView(item: item) { item in
            updateFavorite(item: item)
        }
                .onTapGesture {
                    showDetailScreen(item: item)
                }
    }

    private func ItemsPlaceholderView() -> some View {
        GamesPlaceholderView(description: Strings.doNotGiveUpTheNextGameIsHere)
    }

}

extension HomeScreen {

    private func showDetailScreen(item: GameItem) {
        navigator.navigate {
            GameDetailScreen.build(game: item)
        }
    }

}

extension HomeScreen {

    private func updateFavorite(item: GameItem) {
        vm.updateFavorite(item: item.response) { isAdded in
            let message = isAdded ?
                    Strings.youHaveSuccessfullyAddedThisItemToYourListOfFavorites :
                    Strings.youHaveSuccessfullyRemovedThisItemFromYourListOfFavorites
            showSuccess(message: message)
        }
    }

}

extension HomeScreen {

    private func searchGames() {
        vm.searchGames()
    }

}

extension HomeScreen {

    func onAppear() {
        loadGames()
    }

    private func loadGames() {
        vm.loadGames()
    }
}

extension HomeScreen {

    static func build() -> some View {
        let vm = HomeVM()
        return HomeScreen(vm: vm)
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen.build()
    }
}




//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct HomeScreen: AppScreen {
    @ObservedObject var vm: HomeVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        VStack(alignment: .center) {
            SearchFieldView()
            GamesView()
                    .infiniteHeight()
        }
    }

    private func SearchFieldView() -> some View {
        SearchField(
                title: "",
                text: $vm.search
        )
                .padding(.horizontal, 22)
    }

    private func GamesView() -> some View {
        PagedList(
                vm.gamesState,
                hasMoreItems: vm.canLoadNextPage,
                loadMore: {

                },
                emptyContent: {
                    ItemsPlaceholderView()
                }
        ) { item in
            ItemView(item: item)
        }
    }

    private func ItemView(item: GameItem) -> some View {
        Text(item.name)
    }

    private func ItemsPlaceholderView() -> some View {
        VStack(alignment: .center) {
            Assets.bgApp.swiftUiImage
                    .resizable()
                    .frame(width: 150, height: 150)
            Spacer().frame(height: 32)
            Text(Strings.doNotGiveUpTheNextGameIsHere)
                    .foregroundColor(AppColor.primary3)
                    .appFont(size: 16)
        }
                .infiniteHeight()
    }

}

extension HomeScreen {

    func onAppear() {
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




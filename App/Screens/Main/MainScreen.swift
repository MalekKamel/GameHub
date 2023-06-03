//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

class MainTabScreens {
    lazy var games: AnyView = HomeScreen.build().eraseToAnyView()
    lazy var favorites: AnyView = FavoritesScreen.build().eraseToAnyView()
}

enum MainTabKey: Int {
    case games = 0
    case favorites = 1
}

struct MainScreen: AppScreen {
    @ObservedObject var vm: MainVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        AppTabBar<MainTabKey>(
                tabs: [
                    TabBarItem(key: .games,
                            page: {
                                vm.screens.games
                            }) {
                        TabView(image: .gameControllerFill, title: Strings.games)
                    },
                    TabBarItem(key: .favorites,
                            page: {
                                vm.screens.favorites
                            }) {
                        TabView(image: .heartFill, title: Strings.games)
                    }
                ],
                selectedTab: $vm.selectedTab)
    }

    private func TabView(
            image: AppSystemImage,
            title: String) -> AnyView {
        VStack {
            Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            Spacer().frame(height: 6)
            Text(title)
                    .appFontBold(size: 10)
        }
                .eraseToAnyView()
    }

}

extension MainScreen {

    static func build() -> some View {
        let vm = MainVM()
        return MainScreen(vm: vm)
    }

}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen.build()
    }
}




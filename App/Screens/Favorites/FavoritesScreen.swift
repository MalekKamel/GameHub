//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct FavoritesScreen: AppScreen {
    @ObservedObject var vm: FavoritesVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        VStack(alignment: .center) {
            Text("Favorites")
            Spacer()
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




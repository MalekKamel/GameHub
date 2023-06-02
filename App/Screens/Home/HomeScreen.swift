//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct HomeScreen: AppScreen {
    @ObservedObject var vm: HomeVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        VStack(alignment: .center) {
            Text("Home")
        }
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




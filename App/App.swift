//
// Created by Kamel on 29/05/2023.
//

import SwiftUI
import SwiftUINavigator

struct AppView: View {

    var body: some View {
        NavView(showDefaultNavBar: false) {
            SplashScreen.build()
        }
    }

    static func build() -> some View {
        AppView()
    }
}

//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct SplashScreen: AppScreen {
    @ObservedObject var vm: SplashVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        Group {
            VStack(alignment: .center) {
                Assets.bgApp.swiftUiImage
                        .resizable()
                        .frame(width: 200, height: 200)
                Spacer().frame(height: 32)
                Text(Strings.discoverYourNextFavoriteGame)
                        .foregroundColor(AppColor.primary3)
                        .appFont(size: 16)

            }
                    .infiniteSize()
        }
    }

    func onAppear() {
        handleFlow()
    }

    private func handleFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            navigator.navigate {
                HomeScreen.build()
            }
        }
    }
}

extension SplashScreen {

    static func build() -> some View {
        let vm = SplashVM()
        return SplashScreen(vm: vm)
    }

}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen.build()
    }
}




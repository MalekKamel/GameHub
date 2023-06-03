//
// Created by Kamel on 29/05/2023.
//

import SwiftUI

struct GameDetailScreen: AppScreen {
    @ObservedObject var vm: GameDetailVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer().frame(height: 16)
            HeaderView()
            Spacer().frame(height: 16)
            ItemView(item: vm.game)
            Spacer()
        }
                .padding(.horizontal, 22)
    }

    private func HeaderView() -> some View {
        HStack {
            Button {
                navigator.dismiss()
            } label: {
                Image(systemName: .chevronLeft)
                        .resizable()
                        .frame(width: 10, height: 15)
            }
            Text(vm.game.name)
                    .appFontBold(size: 18)
                    .foregroundColor(AppColor.secondaryBlack)
            Spacer()
        }
    }

    private func ItemView(item: GameItem) -> some View {
        GameItemView(item: item, canFavorite: false)
    }

}

extension GameDetailScreen {

    static func build(game: GameItem) -> some View {
        let vm = GameDetailVM(game: game)
        return GameDetailScreen(vm: vm)
    }

}

struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailScreen.build(game: Fake.shared.game)
    }
}
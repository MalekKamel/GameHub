//
// Created by Kamel on 03/06/2023.
//

import SwiftUI

struct GameItemView: View {
    let item: GameItem
    var canFavorite: Bool = true
    var onUpdateFavorite: ((GameItem) -> Void)? = nil
    @EnvironmentObject var navigator: Navigator

    var body: some View {
        VStack(alignment: .leading) {
            ImageView()
            DescriptionView()
        }
                .onTapGesture {
                    showDetailScreen(item: item)
                }
    }

    private func ImageView() -> some View {
        ZStack(alignment: .topTrailing) {
            AppRemoteImage(url: item.backgroundImage)
                    .resizable()
                    .frame(height: 190)
                    .infiniteWidth()
                    .cornerRadius(5)
            if canFavorite {
                FavoriteView()
                        .padding([.top, .trailing], 5)
            }
        }
    }

    private func DescriptionView() -> some View {
        Group {
            Text(item.name)
                    .appFontBold(size: 18)
                    .foregroundColor(AppColor.secondaryBlack)
            Text(item.genresDescription)
                    .appFont(size: 14)
                    .foregroundColor(AppColor.secondaryBlack)
            Text(String(item.metacritic))
                    .appFont(size: 14)
                    .foregroundColor(AppColor.secondaryRed)
        }
                .padding(.horizontal, 5)
    }

    private func FavoriteView() -> some View {
        Button(action: {
            onUpdateFavorite?(item)
        }) {
            Image(systemName: .heartFill)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                    .background(Color.white)
        }
                .cornerRadius(20)
                .opacity(0.9)
                .shadow(color: AppColor.shadowColor, radius: 0.5, x: 0.3, y: 0.3)
    }
}

extension GameItemView {

    private func showDetailScreen(item: GameItem) {
        navigator.navigate {
            GameDetailScreen.build(game: item)
        }
    }

}
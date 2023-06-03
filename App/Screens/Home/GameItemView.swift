//
// Created by Shaban on 03/06/2023.
//

import SwiftUI

struct GameItemView: View {
    let item: GameItem
    let onAddToFavorites: (GameItem) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            ImageView()
            DescriptionView()
        }
    }

    private func ImageView() -> some View {
        AppRemoteImage(url: item.backgroundImage)
                .resizable()
                .frame(height: 190)
                .infiniteWidth()
                .cornerRadius(5)
                .overlay(
                        FavoriteView()
                                .padding([.top, .trailing], 5), alignment: .topTrailing)
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
            onAddToFavorites(item)
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

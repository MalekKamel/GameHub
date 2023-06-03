//
// Created by Kamel on 03/06/2023.
//

import SwiftUI

struct GamesPlaceholderView: View {
    let description: String

    var body: some View {
        VStack(alignment: .center) {
            Assets.bgApp.swiftUiImage
                    .resizable()
                    .frame(width: 150, height: 150)
            Spacer().frame(height: 32)
            Text(description)
                    .foregroundColor(AppColor.primary3)
                    .appFont(size: 16)
        }
                .infiniteHeight()
    }
}

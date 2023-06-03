//
// Created by Kamel on 21/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct TabBarItem<Key: RawRepresentable>: Identifiable where Key.RawValue == Int {
    public let id = UUID().uuidString
    let key: Key
    let page: AnyView
    let content: AnyView

    public init(key: Key,
                @ViewBuilder page: () -> AnyView,
                @ViewBuilder content: () -> AnyView) {
        self.key = key
        self.page = page()
        self.content = content()
    }
}

public struct AppTabBar<Key: RawRepresentable>: View where Key.RawValue == Int {
    @Binding var selectedTab: Key?
    let tabs: [TabBarItem<Key>]

    public init(tabs: [TabBarItem<Key>],
                selectedTab: Binding<Key?>) {
        self.tabs = tabs
        _selectedTab = selectedTab
    }

    public var body: some View {
        VStack {
            PageView().infiniteHeight()
            Tabs()
        }
                .infiniteHeight()
                .edgesIgnoringSafeArea(.bottom)
    }

    private func PageView() -> some View {
        tabs.first {
                    $0.key.rawValue == selectedId.rawValue
                }?
                .page
    }

    private func Tabs() -> some View {
        VStack {
            Spacer().frame(height: 5)
            VStack(alignment: .center, spacing: 0) {
                Divider()
                TabItems()
            }
                    .background(Color.white)
        }
    }

    private func TabItems() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Spacer().frame(width: 36)
            ForEach(tabs) { item in
                TabItemView(item: item)
            }
            Spacer().frame(width: 36)
        }
                .padding(.top, 20)
                .padding(.bottom, 50)
    }

    private func TabItemView(item: TabBarItem<Key>) -> some View {
        item.content
                .foregroundColor(item.key == selectedId ? AppColor.primary : Color.black)
                .infiniteWidth()
                .scaleEffect(item.key == selectedId ? 1.2 : 1)
                .onTapGesture {
                    self.selectedTab = item.key
                }
    }

    private var selectedId: Key {
        guard let selected = selectedTab else {
            return tabs[0].key
        }
        return selected
    }
}

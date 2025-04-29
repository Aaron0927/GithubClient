//
//  ListModifier.swift
//  GithubClient
//
//  Created by kim on 2025/3/14.
//

import SwiftUI

struct HideListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return content
                .scrollContentBackground(.hidden)
        } else {
            UITableView.appearance().backgroundColor = .clear
            return content
        }
    }
}

extension View {
    func hideListBackground() -> some View {
        modifier(HideListBackgroundModifier())
    }
}

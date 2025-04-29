//
//  LoadingModifier.swift
//  GithubClient
//
//  Created by kim on 2025/3/19.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isLoading {
                ProgressView()
            } else {
                content
            }
        }
    }
}

extension View {
    func loading(isLoading: Bool) -> some View {
        modifier(LoadingModifier(isLoading: isLoading))
    }
}

//
//  ImageView.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var viewModel: ImageViewModel
    
    init(urlString: String) {
        _viewModel = StateObject(wrappedValue: ImageViewModel(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.black)
            }
        }
        .task {
            await viewModel.loadImage()
        }
    }
}

#Preview {
    ImageView(urlString: "https://avatars.githubusercontent.com/u/14815745?v=4")
        .frame(width: 100, height: 100)
}

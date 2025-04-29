//
//  ImageViewModel.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import Foundation
import UIKit

@MainActor
final class ImageViewModel: ObservableObject {
    
    @Published var uiImage: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let service: ImageViewService
    
    init(urlString: String) {
        service = ImageViewService(urlString: urlString)
    }
    
    func loadImage() async {
        do {
            self.isLoading = true
            self.uiImage = try await service.getImage()
            self.isLoading = false
        } catch {
            self.uiImage = nil
        }
    }
}

//
//  ImageViewService.swift
//  GithubClient
//
//  Created by kim on 2025/3/13.
//

import Foundation
import SwiftUI

class ImageViewService {
    private let cacheManager = CacheManager.shared
    private var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getImage() async throws -> UIImage? {
        if let savedImageData = cacheManager.get(forKey: urlString, type: Data.self) {
            return UIImage(data: savedImageData)
        } else {
            return try await downloadImage()
        }
    }
    
    private func downloadImage() async throws -> UIImage? {
        guard let imageURL = URL(string: urlString) else {
            return nil
        }
        let data = try await APIClient.shared.download(imageURL)
        cacheManager.set(data, forKey: urlString)
        let image = UIImage(data: data)
        return image
    }
    
}

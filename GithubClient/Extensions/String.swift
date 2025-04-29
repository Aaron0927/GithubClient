//
//  String.swift
//  GithubClient
//
//  Created by kim on 2025/3/14.
//

import Foundation

extension String {
    // Base64编码
    func encodeBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // Base64解码
    func decodeBase64() -> String? {
        let cleanedBase64Content = self.replacingOccurrences(of: "\n", with: "")
        if let data = Data(base64Encoded: cleanedBase64Content) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

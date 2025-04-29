//
//  KeyChainHelper.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import Foundation
import Security

class KeyChainHelper {
    static let shared = KeyChainHelper()
    private init() {
        self.token = getAccessToken()
    }
    
    private let GitHubAccessTokenKey = "GitHubAccessToken"
    var token: String?
    
    // 保存token
    func saveAccessToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: GitHubAccessTokenKey,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary) // 先删除旧数据，避免重复存储
        SecItemAdd(query as CFDictionary, nil)
        
        self.token = token
    }
    
    // 读取token
    func getAccessToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: GitHubAccessTokenKey,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess {
            if let data = result as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
    // 删除token
    func deleteAccessToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: GitHubAccessTokenKey,
        ]
        
        SecItemDelete(query as CFDictionary)
        
        self.token = nil
    }
}

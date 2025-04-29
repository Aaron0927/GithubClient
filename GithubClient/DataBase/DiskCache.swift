//
//  DiskCache.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

/// 基于FileManage的磁盘缓存
class DiskCache {
    static let shared = DiskCache()
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        cacheDirectory = urls[0].appendingPathComponent("DiskCache")
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(atPath: cacheDirectory.path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func set<T: Codable>(_ object: T, forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = try? JSONEncoder().encode(object) {
            try? data.write(to: fileURL)
        }
    }
    
    func get<T: Codable>(forKey key: String, type: T.Type) -> T? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = try? Data(contentsOf: fileURL) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
    
    func remove(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        try? fileManager.removeItem(at: fileURL)
    }
    
    func clear() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
}

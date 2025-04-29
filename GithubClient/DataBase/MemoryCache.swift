//
//  MemoryCache.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

// 基于NSCache的内存缓存
class MemoryCache {
    static let shared = MemoryCache()
    private let cache = NSCache<NSString, NSData>()
    
    func set<T: Codable>(_ object: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(object) {
            cache.setObject(data as NSData, forKey: key as NSString)
        }
    }
    
    func get<T: Codable>(forKey key: String, type: T.Type) -> T? {
        if let data = cache.object(forKey: key as NSString) as? Data {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
    
    func remove(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}

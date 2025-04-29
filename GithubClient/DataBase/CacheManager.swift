//
//  CacheManager.swift
//  iOSTemplateApp
//
//  Created by kim on 2025/2/25.
//

import Foundation

/**
 统一管理 内存缓存 和 磁盘缓存
 优先从内存读取，缓存不存在时再查找磁盘
 */
class CacheManager {
    static let shared = CacheManager()
    private init() {}
    
    private let memoryCache = MemoryCache.shared
    private let diskCache = DiskCache.shared
    
    func set<T: Codable>(_ object: T, forKey key: String) {
        memoryCache.set(object, forKey: key)
        diskCache.set(object, forKey: key)
    }
    
    func get<T: Codable>(forKey key: String, type: T.Type) -> T? {
        if let object = memoryCache.get(forKey: key, type: type) {
            return object
        } else {
            return diskCache.get(forKey: key, type: type)
        }
    }
    
    func remove(forKey key: String) {
        memoryCache.remove(forKey: key)
        diskCache.remove(forKey: key)
    }
    
    func clearAll() {
        memoryCache.clear()
        diskCache.clear()
    }
}

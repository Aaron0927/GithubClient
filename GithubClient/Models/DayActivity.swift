//
//  DayActivity.swift
//  GithubClient
//
//  Created by kim on 2025/4/10.
//

import Foundation
import SwiftUI

struct DayActivityResponse: Codable {
    let contributions: [[DayActivity]]
    let total: Int
}


/**
 
 */
/// 单天的数据模型
struct DayActivity: Identifiable, Codable, Hashable {
    var id: String { date }
    let date: String
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case count
    }
    
    var color: UIColor {
        switch count {
        case 0: return UIColor(hex: "#e8eaee")
        case 1..<10: return UIColor(hex: "#90e69e")
        case 10..<50: return UIColor(hex: "#38bc58")
        case 50..<100: return UIColor(hex: "#2a9745")
        case 100...: return UIColor(hex: "#1e6332")
        default: return UIColor.clear
        }
    }
    
    static func colors() -> [UIColor] {
        return [
            UIColor(hex: "#e8eaee"),
            UIColor(hex: "#90e69e"),
            UIColor(hex: "#38bc58"),
            UIColor(hex: "#2a9745"),
            UIColor(hex: "#1e6332")
        ]
    }
}

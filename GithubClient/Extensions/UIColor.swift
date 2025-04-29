//
//  UIColor.swift
//  Snow
//
//  Created by kim on 2025/2/10.
//

import Foundation
import UIKit

extension UIColor {
    /// 支持 RGB、RGBA、RRGGBB 和 RRGGBBAA 的颜色初始化方法
    /// - Parameters:
    ///   - hex: UInt32 类型的颜色值
    convenience init(hex: UInt32) {
        let components: (R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat)
        
        switch String(format: "%X", hex).count {
        case 3: // RGB (0xRGB)
            components = (
                R: CGFloat((hex >> 8) & 0xF) / 15.0,
                G: CGFloat((hex >> 4) & 0xF) / 15.0,
                B: CGFloat(hex & 0xF) / 15.0,
                A: 1.0
            )
        case 4: // RGBA (0xRGBA)
            components = (
                R: CGFloat((hex >> 12) & 0xF) / 15.0,
                G: CGFloat((hex >> 8) & 0xF) / 15.0,
                B: CGFloat((hex >> 4) & 0xF) / 15.0,
                A: CGFloat(hex & 0xF) / 15.0
            )
        case 6: // RRGGBB (0xRRGGBB)
            components = (
                R: CGFloat((hex >> 16) & 0xFF) / 255.0,
                G: CGFloat((hex >> 8) & 0xFF) / 255.0,
                B: CGFloat(hex & 0xFF) / 255.0,
                A: 1.0
            )
        case 8: // RRGGBBAA (0xRRGGBBAA)
            components = (
                R: CGFloat((hex >> 24) & 0xFF) / 255.0,
                G: CGFloat((hex >> 16) & 0xFF) / 255.0,
                B: CGFloat((hex >> 8) & 0xFF) / 255.0,
                A: CGFloat(hex & 0xFF) / 255.0
            )
        default:
            // 如果格式不匹配，使用默认白色
            components = (R: 1.0, G: 1.0, B: 1.0, A: 1.0)
        }
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: components.A)
    }
    
    /// 支持 RGB、RGBA、RRGGBB、RRGGBBAA 格式，并支持带 `#` 前缀的字符串
    /// - Parameter hexString: 颜色字符串，例如 `#308FFF`、`308FFF`、`#11223344` 等
    convenience init(hexString: String) {
        // 去除 `#` 前缀
        var cleanedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedString.hasPrefix("#") {
            cleanedString.removeFirst()
        }
        
        // 转换为 UInt32
        var hexValue: UInt64 = 0
        // scanHexInt32(&hexValue)
        Scanner(string: cleanedString).scanHexInt64(&hexValue)
        
        // 根据字符串长度解析颜色
        let components: (R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat)
        switch cleanedString.count {
        case 3: // RGB (0xRGB)
            components = (
                R: CGFloat((hexValue >> 8) & 0xF) / 15.0,
                G: CGFloat((hexValue >> 4) & 0xF) / 15.0,
                B: CGFloat(hexValue & 0xF) / 15.0,
                A: 1.0
            )
        case 4: // RGBA (0xRGBA)
            components = (
                R: CGFloat((hexValue >> 12) & 0xF) / 15.0,
                G: CGFloat((hexValue >> 8) & 0xF) / 15.0,
                B: CGFloat((hexValue >> 4) & 0xF) / 15.0,
                A: CGFloat(hexValue & 0xF) / 15.0
            )
        case 6: // RRGGBB (0xRRGGBB)
            components = (
                R: CGFloat((hexValue >> 16) & 0xFF) / 255.0,
                G: CGFloat((hexValue >> 8) & 0xFF) / 255.0,
                B: CGFloat(hexValue & 0xFF) / 255.0,
                A: 1.0
            )
        case 8: // RRGGBBAA (0xRRGGBBAA)
            components = (
                R: CGFloat((hexValue >> 24) & 0xFF) / 255.0,
                G: CGFloat((hexValue >> 16) & 0xFF) / 255.0,
                B: CGFloat((hexValue >> 8) & 0xFF) / 255.0,
                A: CGFloat(hexValue & 0xFF) / 255.0
            )
        default:
            // 默认白色
            components = (R: 1.0, G: 1.0, B: 1.0, A: 1.0)
        }
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: components.A)
    }
    
    
    /// random color
    var randomColor: UIColor {
        UIColor(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1.0)
    }
}


extension UIColor {
    static let theme = UIColorTheme()
}

struct UIColorTheme {
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let gray = UIColor(named: "GrayColor")
}

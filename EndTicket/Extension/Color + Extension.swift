//
//  Color + Extension.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import SwiftUI

extension Color{
    static let gray50 = Color(#colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1))
    static let gray100 = Color(#colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1))
    static let gray300 = Color(#colorLiteral(red: 0.7506795526, green: 0.7506795526, blue: 0.7506795526, alpha: 1))
    static let gray500 = Color(#colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1))
    static let gray600 = Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
    static let gray900 = Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1))
    static let mainColor = Color(#colorLiteral(red: 0.3254901961, green: 0.7176470588, blue: 0.8666666667, alpha: 1))
    
    var hexString:String{
        let uiColor = UIColor(self)
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else{
            return "#000000"
        }
        
        return String(format: "#%02x%02x%02x%02x",
                      Int(red * 255),
                      Int(green * 255),
                      Int(blue * 255),
                      Int(alpha * 255))
    }
    
    init(hex:String){
        let hex = hex.replacingOccurrences(of: "#", with: "").uppercased()
        print(hex)
        var color:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&color)
        let a, r, g, b: UInt64
        (a, r, g, b) = (255, color >> 16 & 0xFF, color >> 8 & 0xFF, color & 0xFF)
        print("\(a), \(r), \(g), \(b)")
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

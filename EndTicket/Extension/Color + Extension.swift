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
    static let gray200 = Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1))
    static let gray300 = Color(#colorLiteral(red: 0.7506795526, green: 0.7506795526, blue: 0.7506795526, alpha: 1))
    static let gray500 = Color(#colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1))
    static let gray600 = Color(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
    static let gray700 = Color(#colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1))
    static let gray900 = Color(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1))
    static let mainColor = Color(#colorLiteral(red: 0.3254901961, green: 0.7176470588, blue: 0.8666666667, alpha: 1))
    
    //MARK: - Ticket 색
    static let ticketRed1 = Color(hex: "#E591A6")
    static let ticketRed2 = Color(hex:"#E28089")
    static let ticketRed3 = Color(hex: "#C56859")
    
    static let ticketOrange1 = Color(hex:"#EFCB7E")
    static let ticketOrange2 = Color(hex:"#EABD97")
    static let ticketOrange3 = Color(hex:"#E99D7B")
    
    static let ticketGreen1 = Color(hex: "#88C7B2")
    static let ticketGreen2 = Color(hex:"#83ABA5")
    static let ticketGreen3 = Color(hex:"#4CA199")
    
    static let ticketBlue1 = Color(hex:"#8DD3E8")
    static let ticketBlue2 = Color(hex:"#7FBAD5")
    static let ticketBlue3 = Color(hex:"#6D98DE")
    
    static let ticketPurple1 = Color(hex:"#B0BAF0")
    static let ticketPurple2 = Color(hex:"#A49CDA")
    static let ticketPurple3 = Color(hex:"#9F7E99")
    
    static let ticketGray1 = Color(hex:"#C2C8CF")
    static let ticketGray2 = Color(hex:"#A3A8B3")
    static let ticketGray3 = Color(hex:"#616871")
    
    var hexString:String{
        let uiColor = UIColor(self)
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else{
            return "#000000"
        }
        
        return String(format: "#%02x%02x%02x",
                      Int(red * 255),
                      Int(green * 255),
                      Int(blue * 255))
    }
    init(hex:String){
        let hex = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var color:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&color)
        let a, r, g, b: UInt64
        (a, r, g, b) = (255, color >> 16 & 0xFF, color >> 8 & 0xFF, color & 0xFF)
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
        
    }
    
    static let ticketColors:[Color] = [
            .ticketRed1,.ticketRed2,.ticketRed3,
            .ticketOrange1,.ticketOrange2,.ticketOrange3,
            .ticketGreen1,.ticketGreen2,.ticketGreen3,
            .ticketBlue1,.ticketBlue2,.ticketBlue3,
            .ticketPurple1,.ticketPurple2,.ticketPurple3,
            .ticketGray1,.ticketGray2,.ticketGray3
        ]
    
}

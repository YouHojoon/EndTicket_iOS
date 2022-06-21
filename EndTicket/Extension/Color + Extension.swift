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
    
    //MARK: - Ticket 색
    static let ticketRed1 = Color(#colorLiteral(red: 0.8980392157, green: 0.568627451, blue: 0.6509803922, alpha: 1))
    static let ticketRed2 = Color(#colorLiteral(red: 0.8862745098, green: 0.5019607843, blue: 0.537254902, alpha: 1))
    static let ticketRed3 = Color(#colorLiteral(red: 0.7725490196, green: 0.4078431373, blue: 0.3490196078, alpha: 1))
    
    static let ticketOrange1 = Color(#colorLiteral(red: 0.937254902, green: 0.7960784314, blue: 0.4941176471, alpha: 1))
    static let ticketOrange2 = Color(#colorLiteral(red: 0.9176470588, green: 0.7411764706, blue: 0.5921568627, alpha: 1))
    static let ticketOrange3 = Color(#colorLiteral(red: 0.9137254902, green: 0.6156862745, blue: 0.4823529412, alpha: 1))
    
    static let ticketGreen1 = Color(#colorLiteral(red: 0.5333333333, green: 0.7803921569, blue: 0.6980392157, alpha: 1))
    static let ticketGreen2 = Color(#colorLiteral(red: 0.5137254902, green: 0.6705882353, blue: 0.6470588235, alpha: 1))
    static let ticketGreen3 = Color(#colorLiteral(red: 0.2980392157, green: 0.631372549, blue: 0.6, alpha: 1))
    
    static let ticketBlue1 = Color(#colorLiteral(red: 0.5529411765, green: 0.8274509804, blue: 0.9098039216, alpha: 1))
    static let ticketBlue2 = Color(#colorLiteral(red: 0.4980392157, green: 0.7294117647, blue: 0.8352941176, alpha: 1))
    static let ticketBlue3 = Color(#colorLiteral(red: 0.4274509804, green: 0.5960784314, blue: 0.8705882353, alpha: 1))
    
    static let ticketPurple1 = Color(#colorLiteral(red: 0.6901960784, green: 0.7294117647, blue: 0.9411764706, alpha: 1))
    static let ticketPurple2 = Color(#colorLiteral(red: 0.6431372549, green: 0.6117647059, blue: 0.8549019608, alpha: 1))
    static let ticketPurple3 = Color(#colorLiteral(red: 0.6235294118, green: 0.4941176471, blue: 0.6, alpha: 1))
    
    static let ticketGray1 = Color(#colorLiteral(red: 0.7607843137, green: 0.7843137255, blue: 0.8117647059, alpha: 1))
    static let ticketGray2 = Color(#colorLiteral(red: 0.6392156863, green: 0.6588235294, blue: 0.7019607843, alpha: 1))
    static let ticketGray3 = Color(#colorLiteral(red: 0.3803921569, green: 0.4078431373, blue: 0.4431372549, alpha: 1))
    
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

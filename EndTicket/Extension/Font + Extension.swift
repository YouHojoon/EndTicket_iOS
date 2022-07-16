//
//  Font.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import Foundation
import SwiftUI
extension Font{
    static func gmarketSansMeidum(size:CGFloat) -> Font{
        return Font.custom("GmarketSansMedium", size: size)
    }
    static func gmarketSansLight(size:CGFloat) -> Font{
        return Font.custom("GmarketSansLight", size: size)
    }
//    static func appleSDGothicBold(size: CGFloat) -> Font{
//        return Font.custom("Apple SD Gothic Neo Bold", size: size)
//    }
    static func interSemiBold(size: CGFloat) -> Font{
        return Font.custom("Inter-SemiBold", size: size)
    }
    static func interMedium(size: CGFloat) -> Font{
        return Font.custom("Inter-Medium", size: size)
    }
    static func interBold(size: CGFloat) -> Font{
        return Font.custom("Inter-Bold", size: size)
    }
}

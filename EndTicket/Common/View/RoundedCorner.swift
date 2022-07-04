//
//  RoundedCorner.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/04.
//

import Foundation
import SwiftUI
struct RoundedCorner:Shape{
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    init(radius:CGFloat, corners:UIRectCorner){
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

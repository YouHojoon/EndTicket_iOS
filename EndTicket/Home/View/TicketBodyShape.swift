//
//  TicketBodyShape.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct TicketBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let widthRatio = rect.width / 335
        let heightRatio = rect.height / 170
        
        path.move(to: CGPoint(x: 0, y: 20 * heightRatio))
        path.addCurve(to: CGPoint(x: 20 * widthRatio, y: 0), control1: CGPoint(x: 0, y: 9 * heightRatio), control2: CGPoint(x: 9 * widthRatio, y: 0))
        path.addLine(to: CGPoint(x: 253.4 * widthRatio, y: 0))
        path.addCurve(to: CGPoint(x: 256.3 * widthRatio, y: 1.5 * heightRatio), control1: CGPoint(x: 254.5 * widthRatio, y: 0), control2: CGPoint(x: 255.6 * widthRatio, y: 0.6 * heightRatio))
        path.addLine(to: CGPoint(x: 256.3 * widthRatio, y: 1.5 * heightRatio))
        path.addCurve(to: CGPoint(x: 262 * widthRatio, y: 1.5 * heightRatio), control1: CGPoint(x: 257.7 * widthRatio, y: 3.5 * heightRatio), control2: CGPoint(x: 260.6 * widthRatio, y: 3.5 * heightRatio))
        path.addLine(to: CGPoint(x: 262 * widthRatio, y: 1.5 * heightRatio))
        path.addCurve(to: CGPoint(x: 264.9 * widthRatio, y: 0), control1: CGPoint(x: 262.7 * widthRatio, y: 0.6 * heightRatio), control2: CGPoint(x: 263.8 * widthRatio, y: 0))
        path.addLine(to: CGPoint(x: 315 * widthRatio, y: 0))
        path.addCurve(to: CGPoint(x: 335 * widthRatio, y: 20 * heightRatio), control1: CGPoint(x: 326 * widthRatio, y: 0), control2: CGPoint(x: 335 * widthRatio, y: 9 * heightRatio))
        path.addLine(to: CGPoint(x: 335 * widthRatio, y: 150 * heightRatio))
        path.addCurve(to: CGPoint(x: 315 * widthRatio, y: 170 * heightRatio), control1: CGPoint(x: 335 * widthRatio, y: 161 * heightRatio), control2: CGPoint(x: 326 * widthRatio, y: 170 * heightRatio))
        path.addLine(to: CGPoint(x: 264.4 * widthRatio, y: 170 * heightRatio))
        path.addCurve(to: CGPoint(x: 261.7 * widthRatio, y: 168.4 * heightRatio), control1: CGPoint(x: 263.3 * widthRatio, y: 170 * heightRatio), control2: CGPoint(x: 262.3 * widthRatio, y: 169.4 * heightRatio))
        path.addLine(to: CGPoint(x: 261.7 * widthRatio, y: 168.4 * heightRatio))
        path.addCurve(to: CGPoint(x: 256.5 * widthRatio, y: 168.4 * heightRatio), control1: CGPoint(x: 260.6 * widthRatio, y: 166.3 * heightRatio), control2: CGPoint(x: 257.6 * widthRatio, y: 166.3 * heightRatio))
        path.addLine(to: CGPoint(x: 256 * widthRatio, y: 168.4 * heightRatio))
        path.addCurve(to: CGPoint(x: 253.9 * widthRatio, y: 170 * heightRatio), control1: CGPoint(x: 256 * widthRatio, y: 169.4), control2: CGPoint(x: 255 * widthRatio, y: 170 * heightRatio))
        path.addLine(to: CGPoint(x: 20 * widthRatio, y: 170 * heightRatio))
        path.addCurve(to: CGPoint(x: 0, y: 150 * heightRatio), control1: CGPoint(x: 9 * widthRatio, y: 170 * heightRatio), control2: CGPoint(x: 0, y: 161 * heightRatio))
        path.addLine(to: CGPoint(x: 0, y: 20 * heightRatio))


        path.closeSubpath()
        
        return path
    }
}

struct TicketBodyShape_Previews: PreviewProvider {
    static var previews: some View {
       
            TicketBodyShape().frame(width:335, height: 170)
        
        
    }
}

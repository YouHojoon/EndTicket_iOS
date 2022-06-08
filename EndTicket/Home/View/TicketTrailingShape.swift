//
//  TicketTraillingShape.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct TicketTrailingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let widthRatio = rect.width / 76
        let heightRatio = rect.height / 170
        
        path.move(to: CGPoint(x: 0.132812 * widthRatio, y: 3 * heightRatio))
        path.addLine(to: CGPoint(x: 0.832766 * widthRatio, y: 2.8224 * heightRatio))
        path.addCurve(to: CGPoint(x: 2.91491 * widthRatio, y: 1.47048 * heightRatio), control1: CGPoint(x: 1.65675 * widthRatio, y: 2.61333 * heightRatio), control2: CGPoint(x: 2.38866 * widthRatio, y: 2.1381 * heightRatio))
        path.addLine(to: CGPoint(x: 2.91491 * widthRatio, y: 1.47048 * heightRatio))
        path.addCurve(to: CGPoint(x: 5.94636 * widthRatio, y: 0), control1: CGPoint(x: 3.64684 * widthRatio, y: 0.541899 * heightRatio), control2: CGPoint(x: 4.76399 * widthRatio, y: 0))
        path.addLine(to: CGPoint(x: 56.0005 * widthRatio, y: 0))
        path.addCurve(to: CGPoint(x: 76.0005 * widthRatio, y: 20 * heightRatio), control1: CGPoint(x: 67.0462 * widthRatio, y: 0), control2: CGPoint(x: 76.0005 * widthRatio, y: 8.95431 * heightRatio))
        path.addLine(to: CGPoint(x: 76.0005 * widthRatio, y: 150 * heightRatio))
        path.addCurve(to: CGPoint(x: 56.0005 * widthRatio, y: 170 * heightRatio), control1: CGPoint(x: 76.0005 * widthRatio, y: 161.046 * heightRatio), control2: CGPoint(x: 67.0462 * widthRatio, y: 170 * heightRatio))
        path.addLine(to: CGPoint(x: 5.14182 * widthRatio, y: 170 * heightRatio))
        path.addCurve(to: CGPoint(x: 4.05371 * widthRatio, y: 169.74 * heightRatio), control1: CGPoint(x: 4.7637 * widthRatio, y: 170 * heightRatio), control2: CGPoint(x: 4.3909 * widthRatio, y: 169.911 * heightRatio))
        path.addLine(to: CGPoint(x: 4.05371 * widthRatio, y: 169.74 * heightRatio))
        path.addCurve(to: CGPoint(x: 3.25343 * widthRatio, y: 169.084 * heightRatio), control1: CGPoint(x: 3.74253 * widthRatio, y: 169.582 * heightRatio), control2: CGPoint(x: 3.46945 * widthRatio, y: 169.358 * heightRatio))
        path.addLine(to: CGPoint(x: 2.53316 * widthRatio, y: 168.17 * heightRatio))
        path.addCurve(to: CGPoint(x: 0.132812 * widthRatio, y: 166.81 * heightRatio), control1: CGPoint(x: 1.94194 * widthRatio, y: 167.42 * heightRatio), control2: CGPoint(x: 1.0801 * widthRatio, y: 166.932 * heightRatio))
        path.addLine(to: CGPoint(x: 0.132812 * widthRatio, y: 166.81 * heightRatio))
        path.addLine(to: CGPoint(x: 0.132812 * widthRatio, y: 3 * heightRatio))
        path.closeSubpath()
        return path
    }
}

struct TicketTraillingShape_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TicketBodyShape().frame(width: 335, height: 170)
                .foregroundColor(.gray)
                .overlay(
                    TicketTrailingShape().frame(width:75.86,height: 170), alignment: .trailing
            )
            
        }
            
       
        
        
                                  
        
    }
}

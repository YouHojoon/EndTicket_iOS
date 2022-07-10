//
//  TicketBodyShape.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct TicketLeadingShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x:0, y: 0))
            path.addLine(to: CGPoint(x:rect.width, y:0))
            path.addArc(center: CGPoint(x: rect.maxX, y: rect.minY), radius: 5, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
            path.addLine(to: CGPoint(x:rect.width, y:rect.height))
            path.addArc(center: CGPoint(x: rect.maxX, y: rect.maxY), radius: 5, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
            path.addLine(to: CGPoint(x:0, y:rect.height))
        }
    }
}

struct TicketLeadingShape_Previews: PreviewProvider {
    static var previews: some View {
        TicketLeadingShape().frame(width:254, height: 100)
    }
}

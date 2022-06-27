//
//  TicketViewForPrefer.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI

struct TicketViewForPrefer: View {
    private let ticket: Ticket
    init(_ ticket: Ticket){
        self.ticket = ticket
    }
    
    var body: some View {
        
        HStack(spacing:0){
            VStack(alignment:.leading,spacing:8){
                HStack(spacing:5){
                    Text(ticket.title)
                        .font(.system(size: 16,weight: .bold))
                    Capsule()
                        .foregroundColor(.white)
                        .frame(width:33, height: 15)
                        .overlay{Text(ticket.category.rawValue)
                                .foregroundColor(.gray600)
                                .font(.system(size: 10, weight: .bold))
                        }
                }
                HStack(spacing:9){
                    Text("시작역").font(.system(size: 10,weight: .medium))
                    Text(ticket.start).font(.system(size: 12,weight: .bold))
                }
                HStack(spacing:9){
                    Text("종착역").font(.system(size: 10,weight: .medium))
                    Text(ticket.end).font(.system(size: 12,weight: .bold))
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal,15)
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width:90,height: 90)
                .foregroundColor(.white)
                .overlay{
                    Circle().frame(width:50,height: 50)
                        .foregroundColor(ticket.color)
                        .overlay(Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 15,weight: .bold))
                        )
                }
        }.frame(width:335,height: 90)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(ticket.color)
            .shadow(color: Color(#colorLiteral(red: 0.4901960784, green: 0.4901960784, blue: 0.4901960784, alpha: 0.15)), radius: 12, x: 0, y: 7)
        )
    }
}

struct TicketViewForPrefer_Previews: PreviewProvider {
    static var previews: some View {
        TicketViewForPrefer(Ticket.getDummys()[0])
    }
}

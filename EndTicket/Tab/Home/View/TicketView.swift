//
//  TicketView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/06.
//

import SwiftUI

struct TicketView: View {
    private let ticket: Ticket
    init(_ ticket: Ticket){
        self.ticket = ticket
    }
    
    var body: some View{
        HStack(spacing:1){
            TicketLeadingShape()
                .frame(width:258)
                .overlay(
                    //MARK: - 티켓 텍스트 관련
                    VStack(alignment: .leading,spacing:0){
                        HStack(spacing:8){
                            Text(ticket.title).font(Font.appleSDGothicBold(size: 16))
                                .frame(height:20)
                            Capsule()
                                .frame(width:31,height: 15)
                                .overlay{
                                    Text(ticket.type.description)
                                        .font(.appleSDGothicBold(size: 8))
                                        .foregroundColor(.gray600)
                                        .background()
                                }
                        }
                        .padding(.bottom,28)
                        Text("시작역")
                            .font(.appleSDGothicBold(size: 8))
                            .frame(height:8)
                        Text(ticket.startStation).font(.appleSDGothicBold(size: 12))
                            .frame(height:20)
                            .padding(.bottom,16)
                        Text("종착역").font(.appleSDGothicBold(size: 8))
                        Text(ticket.endStation).font(.appleSDGothicBold(size: 12))
                            .frame(height:20)
                    }.foregroundColor(.white)
                        .padding([.leading,.top], 24)
                    , alignment: .topLeading)
            TicketTrailingShape()
                .foregroundColor(.white)
                .frame(width:77)
                .overlay{
                    VStack(spacing:5){
                        Text("0")
                            .font(.appleSDGothicBold(size: 10))
                            .foregroundColor(.gray500)
                            .frame(height: 8)
                        Capsule()
                            .frame(width: 8, height: 78)
                        Text("15")
                            .font(.appleSDGothicBold(size: 10))
                            .foregroundColor(.gray500)
                            .frame(height: 8)
                    }
                    .foregroundColor(.gray)
                }
        }.frame(height:167)
            .cornerRadius(10)
        
    }
    
    
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(Ticket.getDummys()[0])
            .foregroundColor(.blue)
        
    }
}

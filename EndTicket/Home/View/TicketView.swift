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
        Image("ticket_body")
            .renderingMode(.template)
            .frame(width: 335, height: 170)
            .overlay(
                //MARK: - 티켓 텍스트 관련
                VStack(alignment: .leading,spacing:0){
                HStack(alignment:.bottom, spacing:1.97){
                    Text(ticket.title).font(Font.appleSDGothicBold(size: 16))
                        .frame(height:20)
                    Text(ticket.type.description).font(.appleSDGothicBold(size: 8))
                }.padding(.bottom,28)
                Text("시작역").font(.appleSDGothicBold(size: 8))
                    .frame(height:8)
                Text(ticket.startStation).font(.appleSDGothicBold(size: 12))
                    .frame(height:20)
                Text("종착역").font(.appleSDGothicBold(size: 8))
                Text(ticket.endStation).font(.appleSDGothicBold(size: 12))
                    .frame(height:20)
                
            }.foregroundColor(.white)
                .padding(.leading,24.63),alignment: .leading)
            .overlay(
                HStack(spacing:0){
                    Image("ticket_line")
                        .renderingMode(.original)
                    Image("ticket_leading")
                        .renderingMode(.original)
                        .overlay{
                            VStack(spacing:0){
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 20, height: 20)
                                Rectangle().frame(width:3,height: 94)
                                Circle().frame(width:20,height: 20)
                            }
                            .foregroundColor(.gray)
                            
                        }
                }
                ,alignment: .trailing)
    }
    
    
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_Previews.previews
    }
}

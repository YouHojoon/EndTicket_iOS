//
//  TicketView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/06.
//

import SwiftUI

struct TicketView: View {
    private let ticket: Ticket
    @State private var shouldShowModifyForm = false
    @EnvironmentObject private var viewModel: TicketViewModel
<<<<<<< HEAD
<<<<<<< HEAD
    @State private var height: CGFloat = 167

=======
    
>>>>>>> 8ee2460 (delete:fullScreenCoverWithTransiton, add:티켓 수정 화면)
=======
    @State private var height: CGFloat = 167

>>>>>>> 44afafa (fix:TicketView)
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
                                    Text(ticket.category.rawValue)
                                        .font(.appleSDGothicBold(size: 8))
                                        .foregroundColor(.gray600)
                                        .background()
                                }
                        }
                        .padding(.bottom,28)
                        Text("시작역")
                            .font(.appleSDGothicBold(size: 8))
                            .frame(height:8)
                        Text(ticket.start).font(.appleSDGothicBold(size: 12))
                            .frame(height:20)
                            .padding(.bottom,16)
                        Text("종착역").font(.appleSDGothicBold(size: 8))
                        Text(ticket.end).font(.appleSDGothicBold(size: 12))
                            .frame(height:20)
                    }.foregroundColor(.white)
                        .padding([.leading,.top], 24)
                    , alignment: .topLeading)
            TicketTrailingShape()
                .foregroundColor(.white)
                .frame(width:77)
                .overlay{
                    VStack(spacing:5){
                        Text("\(ticket.currentCount)")
                            .font(.appleSDGothicBold(size: 10))
                            .foregroundColor(.gray500)
                            .frame(height: 8)
                        Capsule()
                            .frame(width: 8, height: 78)
                        Text("\(ticket.touchCount)")
                            .font(.appleSDGothicBold(size: 10))
                            .foregroundColor(.gray500)
                            .frame(height: 8)
                    }
                    .foregroundColor(.gray)
                }
        }
        .frame(width:335,height:height)
        .cornerRadius(10)
        .foregroundColor(ticket.color)
<<<<<<< HEAD
<<<<<<< HEAD
        .fullScreenCover(isPresented:$shouldShowModifyForm){
            TicketFormView(ticket)
        }
        .onTapGesture(count: 4){
            viewModel.deleteTicket(id: ticket.id)
        }
        .onTapGesture(count: 3){
            shouldShowModifyForm = true
        }
        .onTapGesture(count: 2){
            viewModel.cancelTouchTicket(id: ticket.id)
        }
        .onTapGesture {
                viewModel.touchTicket(id: ticket.id)
        }
        .onReceive(viewModel.isDeleteTicketSuccess){
            if $0 == ticket.id && $1{
                withAnimation(.easeInOut){
                    height = 0
                }
=======
        .contextMenu(ContextMenu(menuItems: {
            Button{
                viewModel.deleteTicket(id:ticket.id)
            }label: {
                Text("삭제")
>>>>>>> 29eefd1 (add:수정 서버 통신, 터치 기능)
            }
<<<<<<< HEAD
=======
            
            Button{
                withAnimation{
                    shouldShowModifyForm = true
                }
            }label: {
                Text("수정")
            }
        }))
=======
        
        
>>>>>>> 44afafa (fix:TicketView)
        .fullScreenCover(isPresented:$shouldShowModifyForm){
<<<<<<< HEAD
<<<<<<< HEAD
            TicketFormView(ticket)
>>>>>>> 8ee2460 (delete:fullScreenCoverWithTransiton, add:티켓 수정 화면)
        }
        .onTapGesture(count: 4){
            viewModel.deleteTicket(id: ticket.id)
=======
            TicketFormView(ticket).onAppear{
                print(ticket)
            }
>>>>>>> 5a6aee1 (fix:티켓 수정 완성)
=======
            TicketFormView(ticket)
>>>>>>> 4cc7ccc (fix: 티켓 수정화면에서 티켓 색이 선택이 안되어 있는 문제 수정)
        }
//        .onTapGesture(count: 4){
//            viewModel.deleteTicket(id: ticket.id)
//        }
<<<<<<< HEAD
=======
         
>>>>>>> 4cc7ccc (fix: 티켓 수정화면에서 티켓 색이 선택이 안되어 있는 문제 수정)
        .onTapGesture(count: 3){
            shouldShowModifyForm = true
        }
        .onTapGesture(count: 2){
            viewModel.cancelTouchTicket(id: ticket.id)
        }
        .onTapGesture {
                viewModel.touchTicket(id: ticket.id)
        }
        .onReceive(viewModel.isDeleteTicketSuccess){
            if $0 == ticket.id && $1{
                withAnimation(.easeInOut){
                    height = 0
                }
            }
        }
    }
}

//struct TicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketView(Ticket.getDummys()[0])
//            .foregroundColor(.blue)
//
//    }
//}

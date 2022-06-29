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
    @State private var height: CGFloat = 167
    @State private var offset = 0.0
    @State private var shouldShowAlert = false
    @GestureState private var isLongPressed = false
    @EnvironmentObject private var viewModel: TicketViewModel
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
                            Text(ticket.title).font(.system(size: 16,weight: .bold))
                                .frame(height:20)
                            Capsule()
                                .frame(width:31,height: 15)
                                .overlay{
                                    Text(ticket.category.rawValue)
                                        .font(.system(size: 8,weight: .bold))
                                        .foregroundColor(.gray600)
                                        .background()
                                }
                        }
                        .padding(.bottom,28)
                        Text("시작역")
                            .font(.system(size: 8,weight: .bold))
                            .frame(height:8)
                        Text(ticket.start).font(.system(size: 12,weight: .bold))
                            .frame(height:20)
                            .padding(.bottom,16)
                        Text("종착역").font(.system(size: 8,weight: .bold))
                        Text(ticket.end).font(.system(size: 12,weight: .bold))
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
                            .font(.system(size: 10,weight: .bold))
                            .foregroundColor(.gray500)
                            .frame(height:   8)
                        Capsule()
                            .frame(width: 8, height: 78)
                        Text("\(ticket.touchCount)")
                            .font(.system(size: 10,weight: .bold))
                            .foregroundColor(.gray500)
                            .frame(height: 8)
                    }
                    .foregroundColor(.gray)
                }
        }
        .frame(width:335,height:height)
        .cornerRadius(10)
        .foregroundColor(ticket.color)
        .offset(x: offset)
        .gesture(DragGesture()
                 //MARK: - 티켓 스와이프 관련 제스쳐
            .onChanged{value in
                withAnimation{
                    offset = value.translation.width
                }
                
            }
            .onEnded{
                let dragWidth = round(abs($0.translation.width))
                //offset이 음수면 왼쪽
                let ticket = viewModel.tickets.first{$0.id == self.ticket.id}!
                let operation = offset < 0 ? (ticket.currentCount > 0 ?     viewModel.cancelTouchTicket : nil) : (ticket.currentCount <= ticket.touchCount ? viewModel.touchTicket : nil)
                if dragWidth > 335 / 2{
                    operation?(ticket.id)
                }
                withAnimation(.easeInOut){
                    offset = 0
                }
                
            }
        )
        .fullScreenCover(isPresented:$shouldShowModifyForm){
            TicketFormView(ticket)
        }
        
//        .onLongPressGesture{
//            shouldShowAlert = true
//        }
        .gesture(LongPressGesture().updating($isLongPressed){currentState, gestureState, _ in
            gestureState = currentState
            print(isLongPressed)
        })
        .onChange(of: isLongPressed, perform: {
            print($0)
        })
        .onReceive(viewModel.isDeleteTicketSuccess){
            if $0 == ticket.id && $1{
                withAnimation(.easeInOut){
                    height = 0
                }
            }
        }.onReceive(viewModel.isTouchTicketSuccess){id, isSuccess in
            print(viewModel.tickets)
               let index = viewModel.tickets.firstIndex{$0.id == id}!
                let ticket = viewModel.tickets[index]
                if isSuccess && self.ticket.id == id
                    && ticket.touchCount + 1 == ticket.currentCount{
                    withAnimation(.easeInOut){
                        height = 0
                    }
                    viewModel.tickets.remove(at: index)
                }

        }.alert(isPresented: $shouldShowAlert){
            EndTicketAlert{
                Text("변경하시겠습니까?")
                    .font(.system(size: 18,weight: .bold))
            }primaryButton: {
                EndTicketAlertButton(title:Text("수정").foregroundColor(.black)){
                    shouldShowAlert = false
                    shouldShowModifyForm = true
                }
            }secondButton: {
                EndTicketAlertButton(title:Text("삭제").foregroundColor(.red)){
                    shouldShowAlert = false
                    viewModel.deleteTicket(id: ticket.id)
                }
            }
        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(Ticket.getDummys()[0])
            .environmentObject(TicketViewModel())
    }
}

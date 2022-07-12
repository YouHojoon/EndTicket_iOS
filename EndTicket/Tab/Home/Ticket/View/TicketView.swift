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
    @State private var offset = 0.0
    @State private var shouldShowAlert = false //일반 롱프레스 alert
    @State private var shouldShowDeleteAlert = false // 삭제 관련 alert
    @State private var shouldShowModifyOrDeleteAlert = false
    @EnvironmentObject private var viewModel: TicketViewModel
    init(_ ticket: Ticket){
        self.ticket = ticket
        
        
    }
    var body: some View{
        VStack(alignment:.leading,spacing:0){
            HStack{
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.gray100, lineWidth: 1)
                    .frame(width:38, height: 18)
                    .overlay{
                        Text("\(ticket.category.rawValue)")
                            .font(.system(size: 10,weight: .medium))
                            .foregroundColor(.gray500)
                    }
                
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.gray100, lineWidth: 1)
                    .frame(width:38, height: 18)
                    .overlay{
                        Text("\(ticket.touchCount)")
                            .font(.system(size: 10,weight: .medium))
                            .foregroundColor(.gray500)
                    }
                Spacer()
                Text("\(ticket.currentCount)번의 용기").font(.interBold(size: 18))
            }.padding(.bottom, 18)
            
            GeometryReader{proxy in
                Capsule()
                    .frame(height:8)
                    .foregroundColor(.gray100)
                    .overlay(
                        Capsule()
                            .frame(width: proxy.size.width * CGFloat(ticket.currentCount) / CGFloat(ticket.touchCount),height:8)
                        ,alignment: .leading)
            }.frame(height:8)
                .padding(.bottom,16)
            
            HStack(spacing:5){
                Image(systemName: "arrow.right.circle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                    
                Text("\(ticket.subject)")
                    .font(.system(size: 12,weight: .medium))
                    .multilineTextAlignment(.leading)
            }.padding(.bottom,10)
            .foregroundColor(ticket.touchCount != ticket.currentCount ? .black : .gray300)
            HStack(spacing:5){
                Image("goal_icon")
                    .renderingMode(.template)
                    
                Text("\(ticket.purpose)")
                    .font(.system(size: 12,weight: .medium))
                    .multilineTextAlignment(.trailing)
            }.foregroundColor(ticket.touchCount == ticket.currentCount ? .black: .gray300)
            
        }
        .padding(.horizontal,20)
        .frame(width:335,height:150)
        .overlay(
            RoundedCorner(radius: 5, corners: [.bottomLeft, .topLeft])
                .frame(width:5)
            ,alignment: .leading)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color(#colorLiteral(red: 0.4392156863, green: 0.5647058824, blue: 0.6901960784, alpha: 0.15)), radius: 30, x: 0, y: 10)
        
        .foregroundColor(ticket.color)
        .offset(x: offset)
        //scroll을 위한 빈 탭 제스쳐
        .overlay{
            if shouldShowModifyOrDeleteAlert{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black.opacity(0.25))
                    .overlay{
                        HStack(spacing:35){
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:40, height:40)
                                .foregroundColor(.white)
                                .overlay{
                                    Image("edit_square")
                                }
                                .onTapGesture{
                                    shouldShowModifyForm = true
                                    shouldShowModifyOrDeleteAlert = false
                                }
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width:40, height:40)
                                .foregroundColor(Color(#colorLiteral(red: 0.962533772, green: 0.3612903357, blue: 0.2801753879, alpha: 1)))
                                .overlay{
                                    Image("trashcan")
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                }
                                .onTapGesture{
                                    shouldShowDeleteAlert = true
                                    shouldShowModifyOrDeleteAlert = false
                                }
                        }
                    }.transition(.opacity)
            }
        }
        .onTapGesture {
            withAnimation{
                shouldShowModifyOrDeleteAlert = false
            }
        }
        //MARK: - 롱 프레스
        .gesture(LongPressGesture(minimumDuration:0.5)
            .onEnded{_ in
                withAnimation{
                    shouldShowModifyOrDeleteAlert = true
                }
            }
        )
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
        //MARK: - 삭제 alert
        .alert(isPresented: $shouldShowDeleteAlert){
            EndTicketAlertImpl{
                Text("티켓을 삭제하시겠습니까?")
                    .font(.system(size:18,weight:.bold))
            }primaryButton: {
                EndTicketAlertButton(label:Text("취소").foregroundColor(.gray400)){
                    shouldShowDeleteAlert = false
                }
            }secondaryButton: {
                EndTicketAlertButton(label:Text("삭제").foregroundColor(.red)){
                    shouldShowDeleteAlert = false
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

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
    @State private var height: CGFloat = 150
    @State private var offset = 0.0
    @State private var shouldShowAlert = false //일반 롱프레스 alert
    @State private var shouldShowDeleteAlert = false // 삭제 관련 alert
    
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
                Text("\(ticket.currentCount)").font(.interBold(size: 18))
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
            HStack{
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                Spacer()
                Image("futureOfMe_description_icon")
                    .renderingMode(.template)
                    .foregroundColor(ticket.touchCount == ticket.currentCount ? ticket.color : .gray300)
            }.padding(.bottom,5)
            HStack{
                Text("\(ticket.start)")
                    .font(.system(size: 12,weight: .medium))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Spacer()
                Text("\(ticket.end)")
                    .font(.system(size: 12,weight: .medium))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(ticket.touchCount == ticket.currentCount ? ticket.color : .gray300)
            }
                
        }
        .padding(.horizontal,20)
        .frame(width:335,height:height)
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
        .onTapGesture {
            
        }
        //MARK: - 롱 프레스
        .gesture(LongPressGesture(minimumDuration:0.5)
            .onEnded{_ in
                shouldShowAlert = true
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
        .onReceive(viewModel.isDeleteTicketSuccess){
            if $0 == ticket.id && $1{
                withAnimation(.easeInOut){
                    height = 0
                }
            }
        }
        .onReceive(viewModel.isTouchTicketSuccess){id, isSuccess in
               let index = viewModel.tickets.firstIndex{$0.id == id}!
                let ticket = viewModel.tickets[index]
                if isSuccess && self.ticket.id == id
                    && ticket.touchCount + 1 == ticket.currentCount{
                    withAnimation(.easeInOut){
                        height = 0
                    }
                    viewModel.tickets.remove(at: index)
                }

        }
        //MARK: - 롱 프레스 alert
        .alert(isPresented: $shouldShowAlert){
            EndTicketAlert{
                VStack(spacing: 34){
                    HStack{
                        Image("edit_square")
                        Text("수정하기")
                        Spacer()
                    }
                    .clipShape(Rectangle())
                    .onTapGesture {
                        shouldShowAlert = false
                        shouldShowModifyForm = true
                    }
                    HStack{
                        Image("trashcan")
                            .renderingMode(.template)
                        Text("티켓 삭제하기")
                        Spacer()
                    }.foregroundColor(.red)
                    .onTapGesture {
                        shouldShowAlert = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            shouldShowDeleteAlert = true
                        }
                        
                    }
                }.font(.system(size: 16,weight: .bold))
                    .padding(.top, 57)
                    .padding(.bottom,37)
                    .padding(.horizontal,30)
            }primaryButton: {
                EndTicketAlertButton(title:Text("취소").foregroundColor(.gray600), color: .gray50){
                    shouldShowAlert = false
                }
            }
        }
        //MARK: - 삭제 alert
        .alert(isPresented: $shouldShowDeleteAlert){
            EndTicketAlert{
                Text("티켓을 삭제하시겠습니까?")
                    .font(.system(size:18,weight:.bold))
            }primaryButton: {   
                EndTicketAlertButton(title:Text("취소").foregroundColor(.gray400)){
                    shouldShowDeleteAlert = false
                }
            }secondButton: {
                EndTicketAlertButton(title:Text("삭제").foregroundColor(.red)){
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

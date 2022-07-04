//
//  TicketViewForPrefer.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/27.
//

import SwiftUI
import Alamofire

struct TicketViewForPrefer: View {
    private let ticket: Ticket
    @State private var shouldShowAlert = false
    @State private var shouldShowTicketsIsMaxAlert = false
    @State private var isAddButtonTapped = false
    @EnvironmentObject private var viewModel: TicketViewModel
    init(_ ticket: Ticket){
        self.ticket = ticket
    }
    
    var body: some View {
        
        HStack{
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
                }.padding(.bottom, 10)
                
                HStack(spacing:5){
                    Image(systemName: "arrow.right.circle")
                        .font(.system(size: 15))
                        .foregroundColor(.gray500)
                    Text("\(ticket.start)")
                        .font(.system(size: 12,weight: .medium))
                        .foregroundColor(.black)
                }.padding(.bottom,5)
                HStack(spacing:5){
                    Image("futureOfMe_description_icon")
                        .renderingMode(.template)
                        .foregroundColor(.gray500)
                    Text("\(ticket.end)")
                        .font(.system(size: 12,weight: .medium))
                        .foregroundColor(.black)
                }
            }
            Circle().frame(width:50,height: 50)
                .foregroundColor(ticket.color)
                .overlay{
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 18,weight: .semibold))
                    
                }.onTapGesture {
                    if viewModel.tickets.count == 6{
                        shouldShowTicketsIsMaxAlert = true
                    }
                    else{
                        isAddButtonTapped = true
                        viewModel.postTicket(ticket)
                    }
                }
        }
        
        
        .padding(.horizontal,20)
        .frame(width:335,height:100)
        .overlay(
            RoundedCorner(radius: 5, corners: [.bottomLeft, .topLeft])
                .frame(width:5)
            ,alignment: .leading)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color(#colorLiteral(red: 0.4392156863, green: 0.5647058824, blue: 0.6901960784, alpha: 0.15)), radius: 20, x: 0, y: 5)
        
        .foregroundColor(ticket.color)
        .onReceive(viewModel.isPostTicketSuccess){
            if isAddButtonTapped{
                shouldShowAlert = $0
            }
            isAddButtonTapped = false
        }
        .alert(isPresented: $shouldShowAlert){
            EndTicketAlert{
                Text("홈에 추가 되었습니다.")
                    .font(.system(size: 18,weight: .bold))
            }primaryButton: {
                EndTicketAlertButton(title: Text("확인").foregroundColor(.mainColor)){
                    shouldShowAlert = false
                }
            }
        }
        .alert(isPresented: $shouldShowTicketsIsMaxAlert){
            EndTicketAlert{
                VStack(spacing:20){
                    Text("현재 목표에 집중해주세요!")
                        .font(.system(size: 18, weight: .bold))
                        .multilineTextAlignment(.center)
                        .lineSpacing(0.83)
                    Text("새로 추가하고 싶다면\n하나를 삭제하고 추가해주세요:)")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.gray300)
                        .multilineTextAlignment(.center)
                }.foregroundColor(Color.black)
            }primaryButton: {
                EndTicketAlertButton(title:Text("확인").font(.system(size: 16,weight: .bold)).foregroundColor(.mainColor)){
                    shouldShowTicketsIsMaxAlert = false
                }
            }
        }
    }
}

struct TicketViewForPrefer_Previews: PreviewProvider {
    static var previews: some View {
        TicketViewForPrefer(Ticket.getDummys()[0])
    }
}

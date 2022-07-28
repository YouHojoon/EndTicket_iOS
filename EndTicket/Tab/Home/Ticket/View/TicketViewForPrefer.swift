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
    @State private var shouldShowMaxContentAlert = false
    @State private var isAddButtonTapped = false
    @EnvironmentObject private var viewModel: TicketViewModel
    init(_ ticket: Ticket){
        self.ticket = ticket
    }
    
    var body: some View {
        GeometryReader{proxy in
            HStack(spacing:0){
                TicketLeadingShape()
                    .frame(width: proxy.size.width * 0.75)
                    .foregroundColor(.white)
                    .overlay{
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
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.gray500)
                            Text("\(ticket.subject)")
                                .font(.system(size: 12,weight: .medium))
                                .foregroundColor(.black)
                        }.padding(.bottom,5)
                        HStack(spacing:5){
                            Image("goal_icon")
                                .renderingMode(.template)
                                .foregroundColor(.gray500)
                            Text("\(ticket.purpose)")
                                .font(.system(size: 12,weight: .medium))
                                .foregroundColor(.black)
                        }
                    }.padding(.horizontal,20)
            }
                TicketTrailingShape()
                    .frame(width: proxy.size.width * 0.25)
                    .foregroundColor(ticket.color)
                    .overlay{
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 18,weight: .semibold))

                    }.onTapGesture {
                        if viewModel.tickets.count == 6{
                            shouldShowMaxContentAlert = true
                        }
                        else{
                            isAddButtonTapped = true
                            viewModel.postTicket(ticket)
                        }
                    }
            }
            .cornerRadius(5)
            .overlay(
                RoundedCorner(radius: 5, corners: [.bottomLeft, .topLeft])
                    .frame(width:5)
                ,alignment: .leading)
            .cornerRadius(5)
            .shadow(color: Color(#colorLiteral(red: 0.4392156863, green: 0.5647058824, blue: 0.6901960784, alpha: 0.15)), radius: 20, x: 0, y: 5)
            .foregroundColor(ticket.color)
        }.frame(height:100)
            
        .onReceive(viewModel.isSuccessPostTicket){
            if isAddButtonTapped{
                shouldShowAlert = $0
            }
            isAddButtonTapped = false
        }
        .alert(isPresented: $shouldShowAlert){
            EndTicketAlertImpl{
                Text("홈에 추가 되었습니다.")
                    .font(.system(size: 18,weight: .bold))
            }primaryButton: {
                EndTicketAlertButton(label: Text("확인").foregroundColor(.mainColor)){
                    shouldShowAlert = false
                }
            }
        }
        .maxContentAlert(isPresented: $shouldShowMaxContentAlert)
        
    }
}

struct TicketViewForPrefer_Previews: PreviewProvider {
    static var previews: some View {
        TicketViewForPrefer(Ticket.getDummys()[0])
            .environmentObject(TicketViewModel())
    }
}

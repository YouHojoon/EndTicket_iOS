//
//  HomeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/06.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: TicketViewModel
    @Binding private var shouldShowTicketFormView: Bool
    @Binding private var tabIndex: EndTicketTabView.TabIndex
    init(tabIndex:Binding<EndTicketTabView.TabIndex>,shouldShowTicketFormView:Binding<Bool>){
        _shouldShowTicketFormView = shouldShowTicketFormView
        _tabIndex = tabIndex
    }
    var body: some View {
        VStack(spacing:0){
            Group{
                HStack{
                    Text("홈")
                        .kerning(-0.5)
                        .font(.appleSDGothicBold(size: 21))
                    Spacer()
                    Image("home_top_icon")
                        .frame(width:22, height: 22)
                        .onTapGesture {
                            withAnimation{
                                tabIndex = .prefer
                            }
                        }
                }
                .padding(.bottom,23)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray100,lineWidth: 1)
                    .frame(width: 335, height: 50)
                    .overlay{
                        HStack(spacing:7.33){
                            Image(systemName: "clock")
                                .font(.system(size: 13.33,weight: .bold))
                                .foregroundColor(.gray500)
                                .rotationEffect(.degrees(90))
                            Text("21:03:22")
                                .font(.interSemiBold(size: 12))
                                .foregroundColor(.gray500)
                            Spacer()
                            Text("이번주는 터치 6번 목표로 하기")
                                .font(.interSemiBold(size: 14))
                                .foregroundColor(.gray900)
                        }.padding(.horizontal, 24.63)
                    }
                    .padding(.bottom,20)
                    .foregroundColor(.white)
                
            }.background(Color.white.edgesIgnoringSafeArea([.horizontal,.top]))
                .padding(.horizontal,20)
                .padding(.top, 12)
            ZStack(alignment:.top){
                Color
                    .gray50
                    .edgesIgnoringSafeArea([.horizontal,.bottom])
                if viewModel.tickets.isEmpty{
                    VStack(spacing:0){
                        Image("on_boarding_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 230, height: 230)
                            .padding(.bottom, 5)
                        Text("새로운 종착지를 설정해주세요!")
                            .font(.interSemiBold(size: 14))
                            .padding(.bottom, 10)
                        Button{
                            shouldShowTicketFormView = true
                        }label:{
                            Text("새로운 티켓 만들기")
                                .font(.system(size:15,weight: .bold))
                                .foregroundColor(.white)
                                .frame(width:295, height: 50)
                        }.background(Color.mainColor)
                            .cornerRadius(30)
                        
                    }
                    .frame(width:335,height: 335)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top,30)
                }
                else{
                    ScrollView(showsIndicators: false){
                        LazyVStack(spacing:20){
                            ForEach(viewModel.tickets,id: \.id){
                                TicketView($0)
                            }
                        }.padding(.vertical, 30)
                    }
                }
            }
            .onAppear{
                viewModel.fetchTickets()
                UIScrollView.appearance().bounces = true
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketTabView()
    }
}

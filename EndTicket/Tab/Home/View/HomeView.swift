//
//  HomeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/06.
//

import SwiftUI

struct HomeView: View {
    private let color:[Color] = [.blue, .purple, .green, .brown, .indigo]
    
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
            ScrollView(showsIndicators: false){
                LazyVStack(spacing:20){
                    ForEach(0 ..< 5){
                        TicketView(Ticket.getDummys()[$0])
                            .foregroundColor(color[$0])
                            .shadow(color: .white.opacity(0.15), radius: 12, x: 0, y: 0)
                    }
                }.padding(.vertical, 30)
            }
            .background(Color.gray50.edgesIgnoringSafeArea([.horizontal,.bottom]))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

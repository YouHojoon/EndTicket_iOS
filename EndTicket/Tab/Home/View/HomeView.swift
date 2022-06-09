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
            HStack{
                Text("홈")
                    .kerning(-0.5)
                    .font(.gmarketSansMeidum(size: 20))
                Spacer()
                RoundedRectangle(cornerRadius: 5)
                    .frame(width:22, height: 22)
            }
            .padding(.bottom,26)
            
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 335, height: 46)
                .overlay{
                    VStack(alignment:.leading,spacing:2){
                        HStack(spacing:2.96){
                            Image(systemName: "timer")
                                .resizable()
                                .frame(width:8.87, height: 9)
                                
                            Text("21:03:22").font(.gmarketSansLight(size: 10))
                            Spacer()
                        }
                        HStack{
                            Text("이번주는 터치 6번 목표로 하기").font(.gmarketSansMeidum(size: 12))
                        }
                    }.padding(.leading, 24.63)
                        .foregroundColor(Color(#colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1)))
                }
                .padding(.bottom,28)
                .foregroundColor(.white)
                .shadow(color: Color(#colorLiteral(red:0.439,green:0.565,blue:0.69,alpha:0.15)), radius: 24, x: 0, y: 0)
                
                
            
            ScrollView(showsIndicators: false){
                LazyVStack{
                    ForEach(0 ..< 5){
                        TicketView(Ticket.getDummys()[$0])
                        .foregroundColor(color[$0])
                            
                    }
                }
            }
            
        }.padding(.horizontal,20)
            .padding(.top,25)

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

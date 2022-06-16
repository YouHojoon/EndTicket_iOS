//
//  TabView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct EndTicketTabView: View {
    @State private var tabIndex: TabIndex = .home
    private let itemColor = Color(#colorLiteral(red: 0.758, green:0.758, blue: 0.758, alpha: 1))
    var body: some View {
        GeometryReader{proxy in
            ZStack(alignment:.bottom){
                content
                    .padding(.bottom,56)
                    .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                    
                HStack(spacing:0){
                    VStack(spacing:4){
                        Image("home_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:24,height: 24)
                        Text("홈").foregroundColor(itemColor)
                    }.frame(width:proxy.size.width / 5)
                        .onTapGesture {
                            tabIndex = .home
                        }
                    VStack(spacing:4){
                        Image("future_of_me_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:24,height: 24)
                        Text("미래의 나").foregroundColor(itemColor)
                    }.frame(width:proxy.size.width / 5)
                        .onTapGesture {
                            tabIndex = .futureOfMe
                        }

                    ZStack{
                        Circle().frame(width: 36, height: 36).foregroundColor(itemColor)
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.5406724811, green: 0.5406724811, blue: 0.5406724811, alpha: 1)))
                    }.frame(width:proxy.size.width / 5)

                    VStack(spacing:4){
                        Image("history_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:24,height: 24)
                        Text("기록").foregroundColor(itemColor)
                    }.frame(width:proxy.size.width / 5)
                        .onTapGesture {
                            tabIndex = .history
                        }

                    VStack(spacing:4){
                        Image("my_page_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:24,height: 24)
                        Text("마이").foregroundColor(itemColor)
                    }.frame(width:proxy.size.width / 5)
                        .onTapGesture {
                            tabIndex = .myPage
                        }
                }
                .font(.interSemiBold(size: 10))
                .frame(width:proxy.size.width, height: 56).background(Color.white.edgesIgnoringSafeArea(.bottom))
            }.frame(maxWidth:.infinity)
        }
    }
    
    
    @ViewBuilder
    private var content:some View{
        switch tabIndex {
        case .home:
            HomeView()
        case .futureOfMe:
            FutureOfMeView()
                .environmentObject(ImagineViewModel())
        case .history:
            HistoryHomeView()
        case .myPage:
            MyHomeView()
        }
    }
    
    private enum TabIndex{
        case home
        case futureOfMe
        case history
        case myPage
    }
}
    
struct EndTicketTabView_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketTabView()
    }
}

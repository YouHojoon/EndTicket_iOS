//
//  TabView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/08.
//

import SwiftUI

struct EndTicketTabView: View {
    @State private var tabIndex: TabIndex = .home
    @State private var shouldShowTicketFormView = false
    @State private var shouldShowAlert = false
    let ticketViewModel = TicketViewModel()
    var body: some View {
        GeometryReader{proxy in
            ZStack(alignment:.bottom){
                content
                    .fullScreenCover(isPresented: $shouldShowTicketFormView){
                        TicketFormView()
                            .environmentObject(ticketViewModel)
                    }
                    .padding(.bottom,56)//탭바 크기만큼 패딩
                    .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                
                
                //탭바
                HStack(spacing:0){
                    Image("home_icon")
                        .renderingMode(.template)
                        .frame(width:proxy.size.width / 5,height: 40)
                        .overlay(Text("홈")
                            .offset(y:5.5), alignment: .bottom)
                        .onTapGesture {
                            tabIndex = .home
                        }
                        .foregroundColor(tabIndex == .home ? .black : .gray300)
                    
                    tapButton(image: "futureOfMe_icon", title: "미래의 나", width: proxy.size.width / 5)
                    .onTapGesture {
                        tabIndex = .futureOfMe
                    }
                    .foregroundColor(tabIndex == .futureOfMe ? .black : .gray300)
                    
                    ZStack{
                        Circle().frame(width: 39, height: 39).foregroundColor(.black)
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    }.frame(width:proxy.size.width / 5)
                        .onTapGesture {
                            if ticketViewModel.tickets.count == 6{
                                    shouldShowAlert = true
                            }
                            else{
                                withAnimation{
                                    shouldShowTicketFormView = true
                                }
                            }
                        }.alert(isPresented: $shouldShowAlert){
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
                                    shouldShowAlert = false
                                }
                            }
                        }
                    
                    tapButton(image: "history_icon", title: "기록", width: proxy.size.width / 5)
                    .onTapGesture {
                        tabIndex = .history
                    }
                    .foregroundColor(tabIndex == .history ? .black : .gray300)
                    
                    tapButton(image: "my_page_icon", title: "my", width: proxy.size.width / 5)
                    .onTapGesture {
                        tabIndex = .myPage
                    }
                    .foregroundColor(tabIndex == .myPage ? .black : .gray300)
                    
                }
                .font(.system(size: 11,weight: .bold))
                .frame(width:proxy.size.width, height: 56)
                .background(Color.white.edgesIgnoringSafeArea(.bottom))
            }.frame(maxWidth:.infinity)
        }
    }
    
    @ViewBuilder
    private func tapButton(image:String, title:String, width:CGFloat) -> some View{
        Image(image)
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:width,height: 40)
            .overlay(Text(title)
                .offset(y: 5.5), alignment: .bottom)
    }
    
    @ViewBuilder
    private var content:some View{
        switch tabIndex {
        case .home:
            HomeView(tabIndex: $tabIndex,shouldShowTicketFormView: $shouldShowTicketFormView)
                .environmentObject(ticketViewModel)
        case .futureOfMe:
            FutureOfMeView()
                .environmentObject(ImagineViewModel())
        case .history:
            HistoryHomeView()
        case .myPage:
            MyHomeView()
        case .prefer:
            TicketPreferView(tabIndex: $tabIndex)
                .environmentObject(ticketViewModel)
        }
    }
    
    enum TabIndex{
        case home
        case futureOfMe
        case history
        case myPage
        case prefer
    }
}


struct EndTicketTabView_Previews: PreviewProvider{
    static var previews: some View{
        EndTicketTabView()
    }
}

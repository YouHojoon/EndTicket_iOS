//
//  HomeView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/06.
//

import SwiftUI
import Combine
struct HomeView: View {
    @EnvironmentObject private var viewModel: TicketViewModel
    @EnvironmentObject private var missionViewModel: MissionViewModel
    @State private var shouldShowTicketFormView = false
    @State private var shouldShowPepTalk = true
    @State private var tickets:[Ticket] = []
    @Environment(\.scenePhase) var scenePhase
    
    
    var body: some View {
        //MARK: - 위에 뷰
        VStack(alignment:.leading,spacing:0){
            Group{
                if shouldShowPepTalk{
                    Text("\(EssentialToSignIn.nickname.saved ?? "")님\n오늘도 같이 도전해볼까요?")
                        .font(.interBold(size: 22))
                        .padding(.bottom,21)
                }
                //MARK: - 주간 미션
//                HStack(spacing:0){
//                    Image(systemName: "clock")
//                        .font(.system(size: 13))
//                        .foregroundColor(.mainColor)
//                        .padding(.trailing,6.33)
//                    Text("02:00:12")
//                        .font(.interSemiBold(size: 12))
//                        .foregroundColor(.mainColor)
//                        .padding(.trailing,10)
//                    Text("\(missionViewModel.missions.count == 0 ? "" : missionViewModel.missions[0].mission)")
//                        .font(.interSemiBold(size: 14))
//                        .foregroundColor(.gray500)
//                }
//                .padding(.bottom,21)
            }.background(Color.white.edgesIgnoringSafeArea([.horizontal,.top]))
            .padding(.horizontal,20)
            .padding(.top, 12)
            
            
            //MARK: - 티켓 리스트
            ZStack(alignment:.top){
                Color
                    .gray10
                    .edgesIgnoringSafeArea([.horizontal,.bottom])
                if tickets.isEmpty{
                        VStack(spacing:0){
                            Image("ticket_flag")
                                .frame(width: 230, height: 230)
                                .padding(.bottom, 5)
                                .padding(.top, 20)
                            Text("새로운 종착지를 설정해주세요!")
                                .font(.interSemiBold(size: 14))
                                .padding(.bottom, 20)
                            
                            Button{
                                shouldShowTicketFormView = true
                            }label:{
                                Text("새로운 티켓 만들기")
                                    .font(.system(size:15,weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth:.infinity, maxHeight: 50)
                            }.background(Color.mainColor)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal,20)
                    
                }
                else{
                    EndTicketScrollView(isNotScrolled: $shouldShowPepTalk){
                        LazyVStack(spacing:20){
                            ForEach(tickets,id: \.id){
                                TicketView($0)
                            }
                        }.padding(.vertical, 30)
                    }.onTapGesture {
                        viewModel.touchOtherSubject.send(())
                    }
                }   
            }   
        }
        .onAppear{
            viewModel.fetchTickets()
            missionViewModel.fetchMission()
            UIScrollView.appearance().bounces = true
        }
        .fullScreenCover(isPresented: $shouldShowTicketFormView){
            TicketFormView()
        }
        .onReceive(viewModel.$tickets){
            //app이 백그라운드로가면 0으로 날라와서 0이 아닐때만 초기화
            if $0.count != 0{
                tickets = $0
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        EndTicketTabView(needSignUpCharacter: false)
    }
}

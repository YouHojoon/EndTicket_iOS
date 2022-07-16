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
    @State private var shouldMaxContentShowAlert = false
    @State private var shouldShowEditFutureOfMeAlert = false
    @State private var subject = ""
    @State private var shouldShowCharacterSelectAlert = false
    @State private var selectedCharacter: Character = .kia
    @State private var isKeyBoardShow = false
    
    private let ticketViewModel = TicketViewModel()
    private let signUpViewModel = SignUpViewModel()
    private let futureOfMeViewModel = FutureOfMeViewModel()
    private let needSignUpCharacter:Bool
    
    init(needSignUpCharacter: Bool){
        self.needSignUpCharacter = needSignUpCharacter
    }
    
    var body: some View {
        GeometryReader{proxy in
            ZStack(alignment:.bottom){
                VStack(alignment: .leading,spacing:0){
                    header.padding(.horizontal,20)
                        .padding(.top, 23.67)
                    content
                }
                .fullScreenCover(isPresented: $shouldShowTicketFormView){
                    TicketFormView()
                        .environmentObject(ticketViewModel)
                }
                .padding(.bottom,56)//탭바 크기만큼 패딩
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                
                
                //MARK: - 탭바
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
                                shouldMaxContentShowAlert = true
                            }
                            else{
                                withAnimation{
                                    shouldShowTicketFormView = true
                                }
                            }
                        }.maxContentAlert(isPresented: $shouldMaxContentShowAlert)
                    
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
        }.edgesIgnoringSafeArea(isKeyBoardShow ? .bottom : .horizontal)
            .listenKeyBoardShowAndHide($isKeyBoardShow)
        //MARK: - 캐릭터 선택관련
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                withAnimation{
                    shouldShowCharacterSelectAlert = needSignUpCharacter
                }
            }
        }
        .overlay{
            if shouldShowCharacterSelectAlert{
                CharacterSelectAlert()
                    .transition(.opacity)
                    .environmentObject(signUpViewModel)
                    .onReceive(signUpViewModel.$isSuccessSignUpCharacter){
                            self.shouldShowCharacterSelectAlert = !$0
                    }
            }
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
            HomeView()
                .environmentObject(ticketViewModel)
                .environmentObject(MissionViewModel())
        case .futureOfMe:
            FutureOfMeView()
                .environmentObject(futureOfMeViewModel)
        case .history:
            HistoryHomeView()
                .environmentObject(HistoryViewModel())
        case .myPage:
            MyHomeView()
                .environmentObject(MyPageViewModel())
        case .prefer:
            TicketPreferView()
                .environmentObject(ticketViewModel)
        }
    }
    @ViewBuilder
    private var header: some View{
        switch tabIndex {
        case .home:
            HStack{
                Text("홈")
                    .kerning(-0.5)
                    .font(.system(size: 21,weight:.bold))
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:39, height:39)
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
        case .futureOfMe:
            HStack{
                Text("미래의 나")
                    .kerning(-0.5)
                    .font(.system(size: 21,weight: .bold))
                Spacer()
                Image("edit_icon")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .frame(width: 19.5, height: 18.94)
                    .onTapGesture{
                        shouldShowEditFutureOfMeAlert = true
                    }
            }.padding(.bottom, 33)
            //MARK: - Alert
                .alert(isPresented: $shouldShowEditFutureOfMeAlert){
                    EndTicketAlertImpl{
                        VStack{
                            Text("미래의 나를 한마디로 설명해줄래요?")
                                .font(.system(size: 18, weight: .bold))
                                .padding(.bottom, 15)
                            FormTextField(text: $subject,height: 35, maxTextLength: 13,borderColor: .gray300)
                            
                        }.padding(.horizontal, 20)
                            .padding(.bottom,30)
                            .padding(.top, 40)
                    }primaryButton: {
                        EndTicketAlertButton(label: Text("취소").foregroundColor(.gray400)){
                            shouldShowEditFutureOfMeAlert = false
                        }
                    }secondaryButton: {
                        EndTicketAlertButton(label: Text("제목짓기").foregroundColor(.mainColor)){
                            futureOfMeViewModel.postFutureOfMeSubject(subject)
                            shouldShowEditFutureOfMeAlert = false
                        }
                    }
                }
        case .history:
            Text("기록")
                .kerning(-0.5)
                .font(.system(size: 21,weight: .bold))
                .padding(.bottom,43)
        case .myPage:
            Text("설정")
                .kerning(-0.5)
                .font(.system(size: 21,weight: .bold))
                .padding(.bottom,33)
            
        case .prefer:
            HStack(spacing:0){
                Image(systemName: "arrow.backward")
                    .font(.system(size: 16))
                    .onTapGesture {
                        withAnimation{
                            tabIndex = .home
                        }
                    }
                Spacer()
                Text("추천티켓").font(.system(size: 21,weight: .bold))
                Spacer()
            }.padding(.bottom, 13)
                .background(Color.white)
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


//struct EndTicketTabView_Previews: PreviewProvider{
//    static var previews: some View{
//        EndTicketTabView()
//    }
//}

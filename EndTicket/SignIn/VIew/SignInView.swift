//
//  LoginView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    @AppStorage("isFirstStart") private var isFirstStart:Bool = true
    @EnvironmentObject private var viewModel:SignInViewModel
    @State private var shouldGoNextView = false
    @State private var shouldShowProgressView = false
    var body: some View {
        VStack(spacing:12){
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:203, height: 203)
                .overlay(
                    Image("logo_label")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:78,height: 41)
                        .offset(y:21)
                ,alignment: .bottom)
                .padding(.bottom, 121)
                       
            //MARK: - 로그인 버튼
            Group{
                Button{
                    viewModel.socialSignIn(.google)
                }label: {
                    HStack(spacing:21){
                        Image("google_button_symbol")
                            .resizable()
                            .frame(width:18, height: 18)
                        Text("Google로 로그인").kerning(-0.48)
                        Spacer().frame(width:18)
                    }
                   
        
                }.modifier(SignInButtonModifier())
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray300,lineWidth: 1))
                Button{
                    viewModel.socialSignIn(.kakao)
                }label: {
                    HStack(spacing:21){
                        Image("kakao_button_symbol")
                            .resizable()
                            .frame(width:18,height: 18)
                        Text("Kakao로 로그인")
                            .kerning(-0.48)
                        Spacer()
                            .frame(width:18)
                    }
                }.modifier(SignInButtonModifier(Color(#colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1))))
                Button{
                    viewModel.socialSignIn(.apple)
                }label: {
                    HStack(spacing:21){
                            Image("apple_button_symbol")
                            Text("Apple로 로그인")
                            .kerning(-0.48)
                            Spacer()
                            .frame(width:24)
                        //애플 기본 로고 크기가 24
                    }
                }
                .foregroundColor(.white)
                .modifier(SignInButtonModifier(.black))
            }
            
            HStack(spacing:10){
                Text("회원가입")
                Divider()
                    .background(Color.black)
                    .frame(height:10)
                Text("문의하기")
            }.foregroundColor(.gray500)
                .padding(.top, 8)
        }
        .font(.appleSDGothicBold(size: 15))
        .padding(.horizontal, 30)
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .overlay(isFirstStart ? OnBoardingView() : nil)
        .onAppear{
            viewModel.restorePreviousSignIn()
            shouldShowProgressView = true
        }
        .onReceive(viewModel.$status.dropFirst()){status in
            shouldShowProgressView = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                shouldGoNextView = status != .fail
            }
           
        }
        .fullScreenCover(isPresented: $shouldGoNextView){
            viewModel.disconnect()
        }content:{
            switch viewModel.status{
            case .fail:
                EmptyView()
            case .success:
                EndTicketTabView()
            case .needSignUp:
                SignUpView().environmentObject(SignUpViewModel())
            }
        }
        .progressView(isPresented: $shouldShowProgressView)
      
    }
}


struct SignInView_Previews:PreviewProvider{
    static var previews: some View{
        SignInView().environmentObject(SignInViewModel(googleClientId: "test"))
    }
}

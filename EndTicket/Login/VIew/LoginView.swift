//
//  LoginView.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @AppStorage("isFirstStart") private var isFirstStart:Bool = true
    @EnvironmentObject private var viewModel:LoginViewModel
    
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
                    viewModel.googleSignIn()
                }label: {
                    HStack(spacing:21){
                        Image("google_button_symbol")
                            .resizable()
                            .frame(width:18, height: 18)
                        Text("Google로 로그인").kerning(-0.48)
                        Spacer().frame(width:18)
                    }
                   
        
                }.modifier(LoginButtonModifier())
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray300,lineWidth: 1))
                Button{
                    viewModel.kakaoSignIn()
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
                }.modifier(LoginButtonModifier(Color(#colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1))))
                Button{
                    viewModel.appleSignIn()
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
                .modifier(LoginButtonModifier(.black))
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
        }
        .overlay(viewModel.isSignIn ? SignUpView()
            .transition(.opacity)
            .background(Color.white)
            .environmentObject(SignUpViewModel()) : nil)
    }
}


struct LoginView_Previews:PreviewProvider{
    static var previews: some View{
        LoginView().environmentObject(LoginViewModel(googleClientId: "test"))
    }
}

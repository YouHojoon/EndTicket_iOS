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
    @State private var shouldShowLaunchScreen = false
    @Environment(\.dismiss) private var dismiss
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
                .padding(.bottom, 130)
            
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
                            .foregroundColor(.black)
                        Spacer().frame(width:18)
                    }.frame(maxWidth:.infinity, maxHeight: 50)
                }
                .background(.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray300,lineWidth: 1))
                .padding(.horizontal,20)
                
                
                Button{
                    viewModel.socialSignIn(.kakao)
                }label: {
                    HStack(spacing:21){
                        Image("kakao_button_symbol")
                            .resizable()
                            .frame(width:18,height: 18)
                        Text("Kakao로 로그인")
                            .kerning(-0.48)
                            .foregroundColor(.black)
                        Spacer()
                            .frame(width:18)
                    }.frame(maxWidth:.infinity, maxHeight: 50)
                }.background(Color(#colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)))
                .cornerRadius(10)
                .padding(.horizontal,20)
                
                Button{
                    viewModel.socialSignIn(.apple)
                }label: {
                    HStack(spacing:21){
                        Image("apple_button_symbol")
                        Text("Apple로 로그인")
                            .kerning(-0.48)
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width:24)
                        //애플 기본 로고 크기가 24
                    }.frame(maxWidth:.infinity, maxHeight: 50)
                }
                
                .background(.black)
                .cornerRadius(10)
                .padding(.horizontal,20)
                
            }
            
        }
        .font(.system(size: 15,weight: .bold))
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .overlay(isFirstStart ? OnBoardingView() : nil)
        .overlay(shouldShowLaunchScreen ? LaunchScreen().transition(.opacity) : nil)
        .animation(.easeInOut, value: viewModel.status)
        .onAppear{
            shouldShowLaunchScreen = true
            viewModel.restorePreviousSignIn()
        }
        .onReceive(viewModel.$status.dropFirst()){status in
            shouldShowLaunchScreen  = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                shouldGoNextView = status != .fail
            }
            
        }
        .fullScreenCover(isPresented: $shouldGoNextView){
            switch viewModel.status{
            case .fail:
                Color.clear.onAppear{
                    UIApplication.shared.keyWindow?.rootViewController!.dismiss(animated: true)
                }
            case .success:
                EndTicketTabView()
                    .environmentObject(FutureOfMeViewModel())
            case .needSignUp:
                SignUpView()
                    .environmentObject(SignUpViewModel()).onDisappear{
                        viewModel.refreshStatus()
                    }
            }
         } 
    }
}


struct SignInView_Previews:PreviewProvider{
    static var previews: some View{
        SignInView().environmentObject(SignInViewModel(googleClientId: "test"))
    }
}

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
    @AppStorage("isFirstStart") private var isFirstStart:Bool = false
    let gidConfig: GIDConfiguration
    init(googleClientId:String){
        gidConfig = GIDConfiguration(clientID: googleClientId)
    }
    var body: some View {
        VStack(spacing:12){
            Rectangle()
                .foregroundColor(.gray.opacity(0.5))
                .frame(width:203, height: 203)
                .padding(.bottom, 151)
            
            Button{
                
            }label: {
                HStack{
                    Image("google_button_symbol")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 10)
                    Text("Google로 로그인")
                        .font(.gmarketSansMeidum(size: 15))
                        .kerning(-0.48)
                        .frame(height:27)
                }
            }.modifier(LoginButtonModifier())
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 4))
            Button{
                
            }label: {
                HStack(spacing:0){
                    Image("kakao_button_symbol")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 24)
                    Text("Kakao로 로그인")
                        .font(.gmarketSansMeidum(size: 15))
                        .kerning(-0.48)
                }
            }.modifier(LoginButtonModifier(Color(#colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1))))
            Button{
                
            }label: {
                HStack(spacing:0){
                    Image("apple_button_symbol")
                        .frame(maxHeight:56)
                    Text("Apple로 로그인")
                        .font(.gmarketSansMeidum(size: 15))
                        .kerning(-0.48)
                    Spacer().frame(width:24)
                }
            }
            .foregroundColor(.white)
            .modifier(LoginButtonModifier(.black))
        }
        .padding(.horizontal, 30)
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .overlay(isFirstStart ? OnBoarding.home.view.transition(.opacity) : nil)
    }
}


struct LoginView_Previews:PreviewProvider{
    static var previews: some View{
        LoginView(googleClientId: "tet")
    }
}

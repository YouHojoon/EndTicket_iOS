//
//  EndTicketApp.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//

import SwiftUI
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct EndTicketApp: App {
    private let googleClientId: String
    init(){
        guard let cetentialListFile = Bundle.main.url(forResource: "Credential", withExtension: "plist"), let credentialList = NSDictionary(contentsOf: cetentialListFile) else{
            fatalError("SNS Login을 위한 Credential.plist가 존재하지 않습니다.")
        }
        guard let googleClientId = credentialList["GOOGLE_CLIENT_ID"] as? String, let kakaoClientId = credentialList["KAKAO_CLIENT_ID"] as? String else{
            fatalError("SNS Login을 위한 클라이언트 아이디가 존재하지 않습니다.")
        }
        self.googleClientId = googleClientId
        KakaoSDK.initSDK(appKey: kakaoClientId)
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView().onOpenURL{
                if AuthApi.isKakaoTalkLoginUrl($0){
                    AuthController.handleOpenUrl(url: $0)
                }
                else{
                    GIDSignIn.sharedInstance.handle($0)
                }
            }
            .environmentObject(LoginViewModel(googleClientId: googleClientId))
        }
    }
}

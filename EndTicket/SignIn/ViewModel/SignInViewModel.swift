//
//  LoginViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/30.
//

import Foundation
import GoogleSignIn

import Combine
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices
import SwiftUI
import UIKit
final class SignInViewModel: NSObject, ObservableObject{
    @Published var isSignIn = false
    
    private let gidConfig: GIDConfiguration
    private var subscriptions = Set<AnyCancellable>()
    private var asAuthDelegate:ASAuthorizationControllerDelegate?
    
    init(googleClientId:String){
        gidConfig = GIDConfiguration(clientID: googleClientId)
    }
    
    func socialSignIn(_ type: SocialType){
        switch type {
        case .google:
            googleSignIn()
        case .kakao:
            kakaoSignIn()
        case .apple:
            appleSignIn()
        }
    }
    
    
    //MARK: - SNS 로그인
    private func kakaoSignIn(){
        UserApi.shared.loginWithKakaoTalk{
            guard $1 == nil else{
                print($1!.localizedDescription)
                self.isSignIn = false
                return
            }
            guard let _ = $0 else{
                self.isSignIn = false
                return
            }
            withAnimation(.easeInOut){
                self.isSignIn = true
            }
        }
    }
    
    private func appleSignIn(){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        let controller = ASAuthorizationController(authorizationRequests: [request])
        asAuthDelegate = ASAuthorizationControllerDelgateImpl{result in
            withAnimation(.easeInOut){
                self.isSignIn = result
            }
        }
        controller.delegate = asAuthDelegate
        controller.performRequests()
    }
    
    private func googleSignIn(completion: ((Bool)->Void)? = nil){
        guard let windowScenes = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootController = windowScenes.windows.first?.rootViewController else{
            DispatchQueue.main.async {
                self.isSignIn = false
            }
            return
        }
        GIDSignIn.sharedInstance.signIn(with: gidConfig, presenting: rootController){
            guard $1 == nil else{
                print($1!.localizedDescription)
                DispatchQueue.main.async {
                    self.isSignIn = false
                }
                return
            }
            guard let _ = $0 else{
                DispatchQueue.main.async {
                    self.isSignIn = false
                }
                return
            }
            self.signInToServer(.google, idToken: $0!.authentication.idToken!){result in
                DispatchQueue.main.async {
                    withAnimation{
                        self.isSignIn = result
                    }
                }
            }
        }
    }
    
    private func signInToServer(_ type: SocialType, idToken:String, completion: ((Bool) -> Void)?){
        SignInApi.shared.socialSignIn(type,token: idToken)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("로그인 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {token in
                let saveResult = KeyChainManager.saveInKeyChain(key: "token", data: token)
                completion?(saveResult)
            }).store(in: &self.subscriptions)
    }
    
    //MARK: - 자동 로그인 관련
    //처리가 끝났다는 것을 알기 위해서 completion 사용
    func restorePreviousSignIn(){
        restorePreviousAppleSignIn{
            print("apple \($0)")
            //애플 로그인
            if !$0{
                self.restorePreviousGoogleSignIn{
                    //구글 로그인
                    print("google \($0)")
                    if !$0{
                        self.restorePreviousKakaoSignIn{result in
                            print("kakao \(result)")
                            withAnimation(.easeInOut){
                                DispatchQueue.main.async {
                                    self.isSignIn = result
                                }
                            }
                        }
                    }
                    else{
                        withAnimation(.easeInOut){
                            DispatchQueue.main.async{
                                self.isSignIn = true
                            }
                        }
                        
                    }
                }
            }
            else{
                withAnimation(.easeInOut){
                    DispatchQueue.main.async{
                        self.isSignIn = true
                    }
                }
            }
        }
    }
        
    private func restorePreviousAppleSignIn(completion: ((Bool)->Void)? = nil){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        guard let userId = KeyChainManager.readUserInKeyChain() else{
            completion?(false)
            return
        }
        
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                completion?(true)
            case .revoked, .notFound:
                completion?(false)
            default:
                completion?(false)
            }
        }
    }
    
    private func restorePreviousGoogleSignIn(completion: ((Bool)->Void)? = nil){
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            guard $1 == nil else{
                print($1!.localizedDescription)
                completion?(false)
                return
            }
            guard $0 != nil else{
                completion?(false)
                return
            }
            self.signInToServer(.google, idToken: $0!.authentication.idToken!){
                print($0)
               completion?($0)
            }
        }
    }
    
    private func restorePreviousKakaoSignIn(completion: ((Bool)->Void)? = nil){
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print(sdkError.localizedDescription)
                    }
                    else {
                        //기타 에러
                        print(error.localizedDescription)
                    }
                    completion?(false)
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    completion?(true)
                }
            }
        }
        else {
            //로그인 필요
            completion?(false)
        }
    }
}

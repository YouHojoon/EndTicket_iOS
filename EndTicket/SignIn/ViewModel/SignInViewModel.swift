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
    @Published var status: SignInStaus = .fail
    
    private let gidConfig: GIDConfiguration
    private var subscriptions = Set<AnyCancellable>()
    private var asAuthDelegate:ASAuthorizationControllerDelegate?
    private var socialType: SocialType? = nil
    
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
    private func googleSignIn(){
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
            self.signInToServer(.google, idToken: $0!.authentication.idToken!){
                self.handleSignInToServerResult($0, socialType: .google)
            }
        }
    }
    private func signInToServer(_ type: SocialType, idToken:String, completion: ((SignInStaus) -> Void)? = nil){
        print(idToken)
        if KeyChainManager.readInKeyChain(key: "token") == nil || UserDefaults.standard.string(forKey: "nickname") == nil{
            SignInApi.shared.socialSignIn(type,token: idToken)
                .sink(receiveCompletion: {
                    switch $0{
                    case .finished:
                        break
                    case .failure(let error):
                        print("로그인 실패 : \(error.localizedDescription)")
                    }
                }, receiveValue: {nickname,token in
                    guard let token = token else{
                        completion?(.fail)
                        return
                    }
                  
                    guard KeyChainManager.saveInKeyChain(key: "token", data: token) else{
                        completion?(.fail)
                        return
                    }
                    guard let nickname = nickname else{
                        completion?(.needSignUp)
                        return
                    }
                   
                    UserDefaults.standard.set(nickname, forKey: nickname)
                    completion?(.success)
                }).store(in: &self.subscriptions)
        }
        else{completion?(.success)}
    }
    private func handleSignInToServerResult(_ status: SignInStaus, socialType: SocialType){
        self.status = status
        self.socialType = socialType
        
        if status != .fail{
            DispatchQueue.main.async {
                withAnimation{
                    self.isSignIn = true
                }
            }
        }
    }
    
    //MARK: - 자동 로그인 관련
    func restorePreviousSignIn(){
        for sns in SocialType.allCases{
            if isSignIn{
                break
            }
            
            restorePreviousSocialSignIn(sns){
                guard let token = $0 else{
                    return
                }
                self.signInToServer(sns, idToken: token){
                    self.handleSignInToServerResult($0, socialType: sns)
                }
            }
        }
        isSignIn = false
    }
    
    
    
    private func restorePreviousSocialSignIn(_ socialType: SocialType, completion: ((String?) -> Void)? = nil){
        switch socialType {
        case .google:
            restorePreviousGoogleSignIn()
        case .kakao:
            restorePreviousKakaoSignIn()
        case .apple:
            restorePreviousAppleSignIn()
        }
    }
    private func restorePreviousAppleSignIn(completion: ((String?)->Void)? = nil){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        guard let userId = KeyChainManager.readUserInKeyChain() else{
            completion?(nil)
            return
        }
        
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                completion?(nil)
            case .revoked, .notFound:
                completion?(nil)
            default:
                completion?(nil)
            }
        }
    }
    private func restorePreviousGoogleSignIn(completion: ((String?)->Void)? = nil){
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            guard $1 == nil else{
                print($1!.localizedDescription)
                completion?(nil)
                return
            }
            guard $0 != nil else{
                completion?(nil)
                return
            }
            
            completion?($0!.authentication.idToken)
        }
    }
    private func restorePreviousKakaoSignIn(completion: ((String?)->Void)? = nil){
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { (t, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                        print(sdkError.localizedDescription)
                    }
                    else {
                        //기타 에러
                        print(error.localizedDescription)
                    }
                    completion?(nil)
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    completion?(nil)
                }
            }
        }
        else {
            //로그인 필요
            completion?(nil)
        }
    }
    func disconnect(){
        guard let socialType = self.socialType else{
            return
        }
        
        switch socialType {
        case .google:
            disconnectGoogle()
        case .kakao:
            break
        case .apple:
            break
        }
        
        disconnectServer()
    }
    private func disconnectGoogle(){
        GIDSignIn.sharedInstance.disconnect{
            guard $0 == nil else{
                print($0!.localizedDescription)
                return
            }
        }
    }
    private func disconnectServer(){
        UserDefaults.standard.removeObject(forKey: "nickname")
        _ = KeyChainManager.deleteUserInKeyChain()
    }
    
}


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
    @Published var status: SignInStaus = .fail
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
                return
            }
            guard let idToken = $0?.idToken else{
                return
            }
            
            self.serverSignIn(.kakao, idToken: idToken){
                self.handleSignInToServerResult($0, socialType: .kakao)
            }
        }
    }
    private func appleSignIn(){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        let controller = ASAuthorizationController(authorizationRequests: [request])
        asAuthDelegate = ASAuthorizationControllerDelgateImpl{
            guard let idToken = $0 else{
                self.status = .fail
                return
            }
            self.serverSignIn(.apple, idToken: idToken){
                self.handleSignInToServerResult($0, socialType: .apple)
            }
        }
        controller.delegate = asAuthDelegate
        controller.performRequests()
    }
    private func googleSignIn(){
        guard let windowScenes = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootController = windowScenes.windows.first?.rootViewController else{
            return
        }
        
        GIDSignIn.sharedInstance.signIn(with: gidConfig, presenting: rootController){
            guard $1 == nil else{
                print($1!.localizedDescription)
                return
            }
            guard let _ = $0 else{
                return
            }
            self.serverSignIn(.google, idToken: $0!.authentication.idToken!){
                self.handleSignInToServerResult($0, socialType: .google)
            }
        }
    }
    private func serverSignIn(_ type: SocialType, idToken:String, completion: ((SignInStaus) -> Void)? = nil){
        if !EssentialToSignIn.isCanSignIn(){
            SignInApi.shared.socialSignIn(type, token: idToken)
                .sink(receiveCompletion: {
                    switch $0{
                    case .finished:
                        break
                    case .failure(let error):
                        print("로그인 실패 : \(error.localizedDescription)")
                    }
                }, receiveValue: {id, nickname,token in
                    guard let token = token, EssentialToSignIn.token.save(data: token) else{
                        completion?(.fail)
                        return
                    }
                    
                    guard let id = id, EssentialToSignIn.id.save(data: id) else{
                        completion?(.fail)
                        return
                    }
                    
                    
                    guard let nickname = nickname, EssentialToSignIn.nickname.save(data: nickname) else{
                        completion?(.needSignUp)
                        return
                    }
                    
                    completion?(.success)
                })
                .store(in: &self.subscriptions)
        }
        else{
            completion?(.success)
        }
    }
    private func handleSignInToServerResult(_ status: SignInStaus, socialType: SocialType){
        DispatchQueue.main.async {
            self.status = status
        }
        
        if status != .fail{
            print("???")
            _ = EssentialToSignIn.socialType.save(data: socialType.rawValue)
        }
    }
    
    //MARK: - 자동 로그인 관련
    func restorePreviousSignIn(){
        if EssentialToSignIn.isCanSignIn(){
            for sns in SocialType.allCases{
                restorePreviousSocialSignIn(sns)
            }
            DispatchQueue.main.async {
                self.status = .success
            }
        }
        else{
            DispatchQueue.main.async {
                self.status = .fail
            }
        }
    }
    
    private func restorePreviousSocialSignIn(_ socialType: SocialType){
        let completion:(Bool) -> Void = {
            if $0{
                _ = EssentialToSignIn.socialType.save(data: socialType.rawValue)
            }
        }
        switch socialType {
        case .google:
            restorePreviousGoogleSignIn(completion: completion)
        case .apple:
            restorePreviousAppleSignIn(completion: completion)
            
        case .kakao:
            restorePreviousKakaoSignIn(completion: completion)
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
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
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
                
                completion?(true)
            }
        }
        else{
            completion?(false)
        }
        
    }
    private func restorePreviousKakaoSignIn(completion: ((Bool)->Void)? = nil){
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
    
    func disconnect(){
        guard let socialType = SocialType(rawValue: EssentialToSignIn.socialType.saved!) else{
            return
        }
        switch socialType {
        case .google:
            disconnectGoogle()
        case .kakao:
            disconncetKakao()
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
    private func disconncetKakao(){
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
    }
    private func disconnectServer(){
        EssentialToSignIn.removeAllOfSaved()
        self.status = .fail
    }
    
}


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
    private let isRestorePreviousSiginInFail = KeyChainManager.readInKeyChain(key: "token") == nil || UserDefaults.standard.string(forKey: "nickname") == nil ||
    UserDefaults.standard.string(forKey: "socialType") == nil
    
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
            
            self.signInToServer(.kakao, idToken: idToken){
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
            self.signInToServer(.apple, idToken: idToken){
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
            self.signInToServer(.google, idToken: $0!.authentication.idToken!){
                self.handleSignInToServerResult($0, socialType: .google)
            }
        }
    }
    private func signInToServer(_ type: SocialType, idToken:String, completion: ((SignInStaus) -> Void)? = nil){
        SignInApi.shared.socialSignIn(type, token: idToken)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("로그인 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {id, nickname,token in
                guard let token = token else{
                    completion?(.fail)
                    return
                }
                
                guard KeyChainManager.saveInKeyChain(key: "token", data: token) else{
                    completion?(.fail)
                    return
                }
                UserDefaults.standard.set(id,forKey: "id")
                
                guard let nickname = nickname else{
                    completion?(.needSignUp)
                    return
                }
                
                UserDefaults.standard.set(nickname, forKey: "nickname")
                completion?(.success)
            }).store(in: &self.subscriptions)
        
       
    }
    private func handleSignInToServerResult(_ status: SignInStaus, socialType: SocialType){
        DispatchQueue.main.async {
            self.status = status
        }
        
        if status != .fail{
            UserDefaults.standard.set(socialType.rawValue, forKey: "socialType")
        }
    }
    
    //MARK: - 자동 로그인 관련
    func restorePreviousSignIn(){
        if isRestorePreviousSiginInFail{
            DispatchQueue.main.async {
                self.status = .fail
            }
        }
        else{
            DispatchQueue.main.async {
                self.status = .success
            }
        }
    }
    
    func disconnect(){
        guard let socialType = SocialType(rawValue: UserDefaults.standard.string(forKey: "socialType")!) else{
            return
        }
        
        switch socialType {
        case .google:
            disconnectGoogle()
        case .kakao:
            disconnetKakao()
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
    private func disconnetKakao(){
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
        UserDefaults.standard.removeObject(forKey: "nickname")
        _ = KeyChainManager.deleteUserInKeyChain()
        self.status = .fail
    }
    
}


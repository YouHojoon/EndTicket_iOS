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
import Alamofire
final class SignInViewModel: NSObject, ObservableObject{
    @Published public private(set) var status: SignInStaus = .fail
    private let gidConfig: GIDConfiguration
    private var subscriptions = Set<AnyCancellable>()
    private var asAuthDelegate:ASAuthorizationControllerDelegate?
    
    init(googleClientId:String){
        gidConfig = GIDConfiguration(clientID: googleClientId)
    }
    
    func refreshStatus(){
        if EssentialToSignIn.isCanSignIn(){
            status = .success
        }
        else{
            status = .fail
        }
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
    private func socialSignInReciveCompletion(_ subscribers: Subscribers.Completion<AFError>, completion: ((SignInStaus) -> Void)? = nil){
        switch subscribers{
        case .finished:
            break
        case .failure(let error):
            print("로그인 실패 : \(error.localizedDescription)")
            completion?(.fail)
        }
    }
    
    private func kakaoSignIn(){
        UserApi.shared.loginWithKakaoTalk{
            guard $1 == nil else{
                print($1!.localizedDescription)
                self.status = .fail
                return
            }
            guard let idToken = $0?.idToken else{
                self.status = .fail
                return
            }
            
            UserApi.shared.me{
                guard $1 == nil else{
                    print($1!.localizedDescription)
                    self.status = .fail
                    return
                }
        
                let email = $0?.kakaoAccount?.email
                self.serverSignIn(.kakao, idToken: idToken){
                    self.handleSignInToServerResult($0,email: email ,socialType: .kakao)
                }
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
            let email = $1
            self.serverSignIn(.apple, idToken: idToken){
                self.handleSignInToServerResult($0, email: email,socialType: .apple)
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
                self.status = .fail
                return
            }
            guard let credential = $0 else{
                self.status = .fail
                return
            }
        
            self.serverSignIn(.google, idToken: credential.authentication.idToken!){
                self.handleSignInToServerResult($0, email: credential.profile?.email, socialType: .google)
            }
        }
    }
    private func serverSignIn(_ type: SocialType, idToken:String, completion: ((SignInStaus) -> Void)? = nil){
        if !EssentialToSignIn.isCanSignIn(){
            SignInApi.shared.socialSignIn(type, token: idToken)
                .sink(receiveCompletion: {
                    self.socialSignInReciveCompletion($0,completion: completion)
                }, receiveValue: {
                    guard let token = $0?.token, EssentialToSignIn.token.save(data: token) else{
                        completion?(.fail)
                        return
                    }
                    
                    guard let id = $0?.accountId, EssentialToSignIn.id.save(data: id) else{
                        completion?(.fail)
                        return
                    }
                    
                    
                    guard let nickname = $0?.nickname, EssentialToSignIn.nickname.save(data: nickname) else{
                        completion?(.needSignUpNickName)
                        return
                    }
                    
                    guard let imageUrl = $0?.characterImageUrl, EssentialToSignIn.imageUrl.save(data: imageUrl) else{
                        completion?(.needSignUpCharacter)
                        return
                    }
                    completion?(.success)
                })
                .store(in: &self.subscriptions)
        }
        else{
            if EssentialToSignIn.imageUrl.saved == nil{
                completion?(.needSignUpCharacter)
            }
            else{
                completion?(.success)
            }
        }
    }
    private func handleSignInToServerResult(_ status: SignInStaus, email: String?, socialType: SocialType){
        var status = status
        
        switch status {
        case .success, .needSignUpNickName:
            fetchEmail{
                if $0 == nil{
                    guard let email = email else {
                        status = .emailNotFound
                        return
                    }
                    
                    self.signUpEmail(email){
                        if !$0{
                            status = .fail
                            return
                        }
                    }
                }
                
                if status != .fail && status != .emailNotFound{
                    _ = EssentialToSignIn.socialType.save(data: socialType.rawValue)
                }
            }
        default:
            break
        }
        self.status = status
    }
    
    //MARK: - 자동 로그인 관련
    func restorePreviousSignIn(){
        if EssentialToSignIn.isCanSignIn(){
            DispatchQueue.main.async {
                if EssentialToSignIn.imageUrl.saved == nil{
                    self.status = .needSignUpCharacter
                }
                else{
                    self.status = .success
                }
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
                print(error.localizedDescription)
            }
            else {
                print("unlink() success.")
            }
        }
    }
    private func disconnectServer(){
        EssentialToSignIn.removeAllOfSaved()
        self.status = .logout
    }
    
    
    private func signUpEmail(_ email: String, completion: ((Bool) -> Void)? = nil){
        SignUpApi.shared.signUpEmail(email).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("이메일 등록 실패 \(error.localizedDescription)")
                completion?(false)
            }
        }, receiveValue: {
            _ = EssentialToSignIn.email.save(data: email)
            completion?($0)
        }).store(in: &subscriptions)
    }
    
    private func fetchEmail(completion: ((String?) -> Void)? = nil){
        SignUpApi.shared.getUserEmail().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("이메일 조회 실패 \(error.localizedDescription)")
                completion?(nil)
            }
        }, receiveValue: {
            completion?($0)
            if $0 != nil{
                _ = EssentialToSignIn.email.save(data: $0!)
            }
        }).store(in: &subscriptions)
    }
}


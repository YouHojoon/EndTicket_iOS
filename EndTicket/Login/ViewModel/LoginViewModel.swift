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

final class LoginViewModel: ObservableObject{
    private let gidConfig: GIDConfiguration
    
    init(googleClientId:String){
        gidConfig = GIDConfiguration(clientID: googleClientId)
    }
    
    func restorePreviousGoogleSignIn(completion: ((Bool)->Void)? = nil){
        GIDSignIn.sharedInstance.restorePreviousSignIn {
            guard $1 == nil else{
                print($1!.localizedDescription)
                completion?(false)
                return
            }
            guard $0 == nil else{
                completion?(false)
                return
            }
            completion?(true)
        }
    }
    
    func googleLogin(completion: ((Bool)->Void)? = nil){
        guard let rootController = UIApplication.shared.windows.first?.rootViewController else{
            completion?(false)
            return
        }
        GIDSignIn.sharedInstance.signIn(with: gidConfig, presenting: rootController){
            guard $1 == nil else{
                print($1!.localizedDescription)
                completion?(false)
                return
            }
            guard let _ = $0 else{
                completion?(false)
                return
            }
            completion?(true)
        }
    }
    
    func restoreKakaoLogin(completion: ((Bool)->Void)? = nil){
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
    
    func kakaoLogin(completion: ((Bool)->Void)? = nil){
        UserApi.shared.loginWithKakaoTalk{
            guard $1 == nil else{
                print($1!.localizedDescription)
                completion?(false)
                return
            }
            guard let _ = $0 else{
                completion?(false)
                return
            }
            completion?(true)
        }
    }
}

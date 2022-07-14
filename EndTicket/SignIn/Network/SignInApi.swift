//
//  LoginApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/23.
//

import Foundation
import Combine
import Alamofire

final class SignInApi:BaseApi{
    static let shared = SignInApi()
    private init() {
        super.init(needInterceptor: false)
    }
    
    
    func socialSignIn(_ socialType: SocialType, token: String) -> AnyPublisher<(String?,String?,String?),AFError>{
        switch socialType {
        case .google:
            return googleSignIn(token: token)
        case .kakao:
            return kakaoSignIn(token: token)
        case .apple:
            return appleSignIn(token: token)
        }
    }
    
    private func googleSignIn(token:String) -> AnyPublisher<(String?,String?,String?),AFError>{//순서대로 id,닉네임 토큰 리턴
        return session.request(SignInRouter.signIn(.google, token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value().map{
                return ($0.result?.id, $0.result?.nickname, $0.result?.token)
            }.eraseToAnyPublisher()
    }
    
    private func kakaoSignIn(token:String) -> AnyPublisher<(String?,String?,String?),AFError>{
        return session.request(SignInRouter.signIn(.kakao, token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value().map{
                return ($0.result?.id, $0.result?.nickname, $0.result?.token)
            }.eraseToAnyPublisher()
    }
    
    private func appleSignIn(token:String) -> AnyPublisher<(String?,String?,String?),AFError>{
        return session.request(SignInRouter.signIn(.apple, token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value().map{
                return ($0.result?.id, $0.result?.nickname, $0.result?.token)
            }.eraseToAnyPublisher()
    }
    
    
}

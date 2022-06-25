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
    

    func socialSignIn(_ type: SocialType, token: String) -> AnyPublisher<(String?,String?),AFError>{
        switch type {
        default:
            return googleSignin(token: token)
        }
    }
    
    
    private func googleSignin(token:String) -> AnyPublisher<(String?,String?),AFError>{//순서대로 닉네밍 토큰 리턴
        return session.request(SignInRouter.signIn(.google, token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value().map{
                return ($0.result?.user, $0.result?.token)
            }.eraseToAnyPublisher()
    }
}

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
    override private init() {
        super.init()
    }
    

    func socialSignIn(_ type: SocialType, token: String) -> AnyPublisher<String,AFError>{
        switch type {
        default:
            return googleSignin(token: token)
        }
    }
    
    
    private func googleSignin(token:String) -> AnyPublisher<String,AFError>{
        return session.request(SignInRouter.signIn(.google, token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value().map{
                $0.token
            }.eraseToAnyPublisher()
    }
}

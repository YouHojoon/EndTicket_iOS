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
    
    func socialSignIn(_ socialType: SocialType, token: String) -> AnyPublisher<UserInfo?,AFError>{
        session.request(SignInRouter.signIn(socialType, idToken:token))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignInResponse.self)
            .value()
            .tryMap{
                if !$0.isSuccess{
                    throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: $0.code))
                }
                return $0.result
            }
            .mapError{
                $0.asAFError ?? AFError.responseValidationFailed(reason: .customValidationFailed(error: $0))
            }
            .eraseToAnyPublisher()
    }

}

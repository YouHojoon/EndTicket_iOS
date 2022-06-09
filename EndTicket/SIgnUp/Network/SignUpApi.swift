//
//  SignUpApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import Combine
import Alamofire

final class SignUpApi{
    static let shared = SignUpApi()
    private init(){}
    
    func signUp(nickname: String) -> AnyPublisher<Void,AFError>{
        return AF.request(SignUpRouter.signUp(nickname))
            .validate(statusCode: 200..<300)
            .publishData()
            .value()
            .flatMap{_ -> Combine.Empty in Combine.Empty<Void,AFError>(completeImmediately: true)}
            .eraseToAnyPublisher()
    }
}

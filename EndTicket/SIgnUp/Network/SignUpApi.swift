//
//  SignUpApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import Combine
import Alamofire

final class SignUpApi: BaseApi{
    static let shared = SignUpApi()
    override private init(){
        super.init()
    }
    
    func signUp(nickname: String) -> AnyPublisher<Bool,AFError>{
        
        session.request(SignUpRouter.signUp(nickname))
            .validate(statusCode: 200..<300)
            .publishData()
            .value()
            .map{
                
                
                
                print(String(data:$0,encoding: .utf8)!)
            }
            .eraseToAnyPublisher()
        
        
        
        
        return session.request(SignUpRouter.signUp(nickname))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignUpResponse.self)
            .value()
            .map{$0.isSuccess}
            .eraseToAnyPublisher()
        }
}

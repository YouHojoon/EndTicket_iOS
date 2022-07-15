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
    private init(){
        super.init()
    }
    
    
    func signUpNickname(_ nickname: String) ->AnyPublisher<Bool,AFError>{
        return session.request(SignUpRouter.signUpNickname(nickname))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignUpNicknameResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
    func signUpCharacter(_ character:Character) -> AnyPublisher<Bool, AFError>{
        return session.request(SignUpRouter.signUpCharacter(character))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:SignUpCharacterResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
    func deleteUser(text:String) -> AnyPublisher<Bool,AFError>{
        return session.request(SignUpRouter.deleteUser(text: text))
            .validate(statusCode:200..<300)
            .publishDecodable(type:DeleteUserResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
}

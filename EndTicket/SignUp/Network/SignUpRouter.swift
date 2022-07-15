//
//  SignUpRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import Alamofire

enum SignUpRouter: BaseRouter{
    case signUpNickname(String)
    case signUpCharacter(Character)
    case deleteUser(text:String)
    
    var endPoint: String{
        let baseEndPoint = "auth/"
        switch self {
        case .signUpNickname:
            return "\(baseEndPoint)/nickname"
        case .signUpCharacter:
            return "\(baseEndPoint)/character"
        case .deleteUser:
            return baseEndPoint
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .signUpNickname(let nickname):
            return [
                "nickname": nickname
            ]
        case .signUpCharacter(let character):
            return [
                "characterId": character.id
            ]
        case .deleteUser(let text):
            return [
                "text": text
            ]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .signUpNickname:
            return .patch
        case .signUpCharacter:
            return .post
        case .deleteUser:
            return .patch
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        if !parameters.isEmpty{
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        request.method = method
        return request
    }
}

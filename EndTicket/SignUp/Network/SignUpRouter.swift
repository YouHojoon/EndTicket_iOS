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
    case signUpEmail(String)
    case deleteUser(text:String)
    case getUserEmail
    
    var endPoint: String{
        let baseEndPoint = "auth/"
        switch self {
        case .signUpNickname:
            return "\(baseEndPoint)/nickname"
        case .signUpCharacter:
            return "\(baseEndPoint)/character"
        case .deleteUser:
            return baseEndPoint
        case .signUpEmail(_), .getUserEmail:
            return "users/email"
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
        case .signUpEmail(let email):
            return [
                "email" : email
            ]
        default:
            return Parameters()
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .signUpCharacter:
            return .post
        case .deleteUser,.signUpEmail,.signUpNickname:
            return .patch
        case .getUserEmail:
            return .get
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

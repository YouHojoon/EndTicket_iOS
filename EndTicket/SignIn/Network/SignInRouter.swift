//
//  SignInRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/23.
//

import Foundation
import Alamofire

enum SignInRouter:BaseRouter{
    case signIn(SocialType, String)
    
    var endPoint: String{
        let baseEndPoint = "auth"
        switch self {
        case .signIn(let socialType, _):
            return "\(baseEndPoint)/ios/\(socialType.rawValue)"
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .signIn(_, let token):
            return [
                "token" : token
            ]
            
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .signIn:
            return .post
        }
    }
    
    var headers: HTTPHeaders{
        return [
            "Content-Type": "application/json; charset=UTF-8"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var requset = URLRequest(url: url)
        requset.method = method
        requset.headers = headers
        requset.httpBody = try! JSONEncoding.default.encode(requset, with: parameters).httpBody
        return requset
    }
}

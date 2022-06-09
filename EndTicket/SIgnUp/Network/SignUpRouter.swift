//
//  SignUpRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import Alamofire

enum SignUpRouter: URLRequestConvertible{
    case signUp(String)
    
    var endPoint: String{
        switch self {
        case .signUp(_):
            return "users/nickname"
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .signUp(let nickname):
            return [
                "parameters": nickname
            ]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .signUp(_):
            return .post
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}

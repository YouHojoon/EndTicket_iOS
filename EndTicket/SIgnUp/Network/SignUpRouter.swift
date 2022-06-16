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
            return "auth/nickname"
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .signUp(let nickname):
            return [
                "nickname": nickname
            ]
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .signUp(_):
            return .patch
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        request.method = method
        return request
    }
}

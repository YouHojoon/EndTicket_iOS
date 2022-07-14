//
//  InquireRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import Alamofire
enum InquireRouter: BaseRouter{
    case inquire(String)
    
    var endPoint: String{
        return "users/inquire"
    }
    
    var method: HTTPMethod{
        return .post
    }
    
    var parameters: Parameters{
        switch self {
        case .inquire(let text):
            return [
                "inquiry": text
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string:EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = try! JSONEncoding.default.encode(request,with:parameters).httpBody
        return request
    }
}

//
//  FutureOfMeRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/07.
//

import Foundation
import Alamofire

enum FutureOfMeRouter: BaseRouter{
    case getFutureOfMe
    case postFutureOfMeSubject(String)
    case getImagine
    case postImagine(Imagine)
    case touchImagine(Int)
    
    var endPoint: String{
        let baseEndPoint = "future"
        switch self {
        case .getFutureOfMe, .postFutureOfMeSubject:
            return "\(baseEndPoint)"
        case .getImagine,  .postImagine:
            return "\(baseEndPoint)/dream"
        case .touchImagine(let imagineId):
            return "\(baseEndPoint)/dream/\(imagineId)"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getFutureOfMe, .getImagine:
            return .get
        case .postImagine, .touchImagine:
            return .post
        case .postFutureOfMeSubject:
            return .patch
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .postFutureOfMeSubject(let subject):
            return ["subject":subject]
        case .postImagine(let imagine):
            return ["subject":imagine.subject, "purpose": imagine.purpose, "color": imagine.color.hexString]
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        if !parameters.isEmpty{
            request.httpBody = try! JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        return request
    }
}

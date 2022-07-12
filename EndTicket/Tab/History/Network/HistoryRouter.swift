//
//  HistoryRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
import Alamofire
enum HistoryRouter: BaseRouter{
    case main
    case detail(HistoryType)
    
    var parameters: Parameters{
        return Parameters()
    }
    
    var endPoint: String{
        let baseEndPoint = "users/logs"
        switch self {
        case .main:
            return "\(baseEndPoint)/main"
        case .detail(let type):
            return "\(baseEndPoint)/\(type.rawValue)"
        }
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}

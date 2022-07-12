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
    case ticket(Ticket.Category)
    case mission
    case futureOfMe
    
    var parameters: Parameters{
        return Parameters()
    }
    
    var endPoint: String{
        let baseEndPoint = "users/logs"
        switch self {
        case .main:
            return "\(baseEndPoint)/main"
        case .ticket(let category):
            if category == .all{
                return "\(baseEndPoint)/ticket"
            }
            else{
                return "\(baseEndPoint)/ticket?category=\(category.rawValue)"
            }
        case .mission:
            return "\(baseEndPoint)/mission"
        case .futureOfMe:
            return "\(baseEndPoint)/dream"
            
        }
    }
    
    var method: HTTPMethod{
        return .get
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.url = url
        request.method = method
        return request
    }
}

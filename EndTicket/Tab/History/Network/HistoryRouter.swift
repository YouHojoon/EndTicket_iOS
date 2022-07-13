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
    case imagine
    
    var parameters: Parameters{
        return Parameters()
    }
    
    var endPoint: String{
        let baseEndPoint = "users/logs"
        switch self {
        case .main:
            return "\(baseEndPoint)/main"
        case .ticket:
                return "\(baseEndPoint)/ticket"
        case .mission:
            return "\(baseEndPoint)/mission"
        case .imagine:
            return "\(baseEndPoint)/dream"
            
        }
    }
    var query: URLQueryItem?{
        switch self {
        case .ticket(let category):
            return URLQueryItem(name: "category", value: category == .all ? nil : category.rawValue)
        default:
            return nil
        }
    }
    var method: HTTPMethod{
        return .get
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        
        if query != nil{
            var componet = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            componet.queryItems = [query!]
            url = componet.url!
        }
        
        var request = URLRequest(url: url)
        request.url = url
        request.method = method
        return request
    }
}

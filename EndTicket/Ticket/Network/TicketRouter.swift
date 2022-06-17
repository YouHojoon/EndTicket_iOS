//
//  TicketRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import Alamofire

enum TicketRouter: RouterProtocol{
    case getTicket
    case postTicket(Ticket)
    case deleteTicket
    case ticketTouch(Int)
    case modifyTicket(Int)
    case getWeekendGoal
    
    var endPoint: String{
        let baseEndPoint = "ticket"
        
        switch self {
        case .getTicket, .postTicket, .deleteTicket:
            return "\(baseEndPoint)"
        case .ticketTouch(let ticketId):
            return "\(baseEndPoint)/touch/\(ticketId)"
        case .modifyTicket(let ticketId):
            return "\(baseEndPoint)/\(ticketId)"
        case .getWeekendGoal:
            return "\(baseEndPoint)/goal"
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .postTicket(let ticket):
            return [
                "title" : ticket.title,
                "start" : ticket.start,
                "end" : ticket.end,
                "color" : ticket.color.hexString,
                "category": ticket.category.rawValue,
                "touchCount": ticket.touchCount
            ]
        default:
            return Parameters()
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getTicket:
            return .get
        case .postTicket:
            return .post
        case .deleteTicket:
            return .delete
        case .ticketTouch:
            return .post
        case .modifyTicket:
            return .patch
        case .getWeekendGoal:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        
        switch method{
        case .get,.delete:
            break
        default:
            request.httpBody = try! JSONEncoding.default.encode(request,with: parameters).httpBody
        }
        
        
        return request
    }
    
    
}

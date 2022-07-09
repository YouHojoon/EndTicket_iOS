//
//  TicketRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import Alamofire

enum TicketRouter: BaseRouter{
    case getTicket
    case postTicket(Ticket)
    case deleteTicket(Int)
    case ticketTouch(Int)
    case modifyTicket(Ticket)
    case getWeekendGoal
    case canelTouchTicket(Int)
    case getPreferTicket
    
    var endPoint: String{
        let baseEndPoint = "ticket"
        
        switch self {
        case .getTicket, .postTicket:
            return "\(baseEndPoint)"
        case .deleteTicket(let ticketId):
            return "\(baseEndPoint)/\(ticketId)"
        case .ticketTouch(let ticketId):
            return "\(baseEndPoint)/touch/\(ticketId)"
        case .modifyTicket(let ticket):
            return "\(baseEndPoint)/\(ticket.id)"
        case .getWeekendGoal:
            return "\(baseEndPoint)/goal"
        case .canelTouchTicket(let ticketId):
            return "\(baseEndPoint)/touch/\(ticketId)"
        case .getPreferTicket:
            return "\(baseEndPoint)/\(UserDefaults.standard.string(forKey: "id")!)" // 임시로 userId
        }
    }
    
    var parameters: Parameters{
        switch self {
        case .postTicket(let ticket), .modifyTicket(let ticket):
            return [
                "subject" : ticket.subject,
                "purpose" : ticket.purpose,
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
        case .canelTouchTicket:
            return .delete
        case .getPreferTicket:
            return .get
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)

        var request = URLRequest(url: url)
        request.method = method
        
        if !parameters.isEmpty{
            request.httpBody = try! JSONEncoding.default.encode(request,with: parameters).httpBody
        }
    
        return request
    }
    
    
}

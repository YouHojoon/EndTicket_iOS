//
//  TicketApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

final class TicketApi: BaseApi{
    static let shared = TicketApi()
    
    private override init() {
        super.init()
    }
    
    func getTickets() -> AnyPublisher<[Ticket], AFError>{
        return session.request(TicketRouter.getTicket)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:TicketListResponse.self)
            .value()
            .map{
                $0.result.ticket.map{$0.ticketResponseToTicket()}
            }.eraseToAnyPublisher()
    }
    
    func postTicket(_ ticket: Ticket) -> AnyPublisher<Ticket?, AFError>{
        return session.request(TicketRouter.postTicket(ticket))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:DefaultTicketResponse.self)
            .value()
            .map{
                if $0.isSuccess{
                    return $0.result.ticketResponseToTicket()
                }
                else{
                    return nil
                }
            }.eraseToAnyPublisher()
    }
    
    func deleteTicket(_ ticket: Ticket) -> AnyPublisher<Bool, AFError>{
        return session.request(TicketRouter.deleteTicket(ticket.id)).validate(statusCode: 200..<300)
            .publishDecodable(type:DeleteTicketResponse.self)
            .value()
            .map{
                $0.isSuccess
            }
            .eraseToAnyPublisher()
    }
}

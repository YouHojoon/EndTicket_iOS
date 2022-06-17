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
            .publishDecodable(type:GetTicketResponse.self)
            .value()
            .map{
                $0.result.ticket.map{$0.ticketResponseToTicket()}
            }.eraseToAnyPublisher()
    }
    
    func postTicket(_ ticket: Ticket) -> AnyPublisher<TicketResponse?, AFError>{
        return session.request(TicketRouter.postTicket(ticket))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostTicketResponse.self)
            .value()
            .map{
                if $0.isSuccess{
                    return $0.result
                }
                else{
                    return nil
                }
            }.eraseToAnyPublisher()
    }
}

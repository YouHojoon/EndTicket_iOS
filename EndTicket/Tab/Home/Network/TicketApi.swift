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
    
    var tets = Set<AnyCancellable>()
    func getTicket() -> AnyPublisher<[Ticket], AFError>{
        return session.request(TicketRouter.getTicket)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:GetTicketResponse.self)
            .value()
            .map{
                $0.result.ticket.map{$0.ticketResponseToTicket()}
            }.eraseToAnyPublisher()
    }
}

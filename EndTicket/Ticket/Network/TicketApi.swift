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
<<<<<<< HEAD

=======
>>>>>>> 29eefd1 (add:수정 서버 통신, 터치 기능)
    func postTicket(_ ticket: Ticket) -> AnyPublisher<Ticket?, AFError>{
        return session.request(TicketRouter.postTicket(ticket))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostOrModifyTicketResponse.self)
<<<<<<< HEAD
            .value()
            .map{
                $0.result.ticketResponseToTicket()
            }.eraseToAnyPublisher()
    }

    func deleteTicket(id: Int) -> AnyPublisher<Bool, AFError>{
        return session.request(TicketRouter.deleteTicket(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:DeleteTicketResponse.self)
            .value()
            .map{
                $0.isSuccess
            }
            .eraseToAnyPublisher()
    }

    func modifyTicket(_ ticket: Ticket) -> AnyPublisher<Ticket?, AFError>{// 미완
        return session.request(TicketRouter.modifyTicket(ticket))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostOrModifyTicketResponse.self)
=======
>>>>>>> 781b4c9 (rename:DefaultTicketResponse를 PostOrModifyTicketResponse로 변경)
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
<<<<<<< HEAD
    func touchTicket(id: Int) -> AnyPublisher<Bool, AFError>{
        return session.request(TicketRouter.ticketTouch(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:TouchTicketResponse.self)
=======
    func deleteTicket(id: Int) -> AnyPublisher<Bool, AFError>{
        return session.request(TicketRouter.deleteTicket(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:DeleteTicketResponse.self)
>>>>>>> 29eefd1 (add:수정 서버 통신, 터치 기능)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
    func canelTouchTicket(id: Int) -> AnyPublisher<Bool,AFError>{
        return session.request(TicketRouter.canelTouchTicket(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:CancelTouchTicket.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
    func modifyTicket(_ ticket: Ticket) -> AnyPublisher<Ticket?, AFError>{// 미완
        return session.request(TicketRouter.modifyTicket(ticket))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostOrModifyTicketResponse.self)
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
    func touchTicket(id: Int) -> AnyPublisher<Bool, AFError>{
        return session.request(TicketRouter.ticketTouch(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:TouchTicketResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
    func canelTouchTicket(id: Int) -> AnyPublisher<Bool,AFError>{
        return session.request(TicketRouter.canelTouchTicket(id)).validate(statusCode: 200..<300)
            .publishDecodable(type:CancelTouchTicket.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
}


//
//  HistoryApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
import Combine
import Alamofire
final class HistoryApi: BaseApi{
    static let shared = HistoryApi()
    private init(){
        super.init(needInterceptor: true)
    }
    
    func getMainHistory() -> AnyPublisher<MainHistory?,AFError>{
        return session.request(HistoryRouter.main)
            .publishDecodable(type:GetMainHistroyResponse.self)
            .value()
            .map{
                $0.result
            }.eraseToAnyPublisher()
    }
    
    func getTicketHistory(category:Ticket.Category) -> AnyPublisher<[Ticket],AFError>{
        return session.request(HistoryRouter.ticket(category))
            .publishDecodable(type:TicketListResponse.self)
            .value()
            .map{
                $0.result?.ticket.map{$0.ticketResponseToTicket()} ?? []
            }.eraseToAnyPublisher()
    }
    func getImagineHistory()-> AnyPublisher<[Imagine], AFError>{
        return session.request(HistoryRouter.imagine)
            .publishDecodable(type:GetImagineResponse.self)
            .value()
            .map{
                $0.result?.dream.map{$0.imagineResponseToImagine()} ?? []
            }.eraseToAnyPublisher()
    }
    func getMissionHistory() -> AnyPublisher<[MissionHistoryResponse], AFError>{
        return session.request(HistoryRouter.mission)
            .publishDecodable(type:GetMissionHistoryResponse.self)
            .value()
            .map{
                $0.result?.mission ?? []
            }.eraseToAnyPublisher()
    }
}

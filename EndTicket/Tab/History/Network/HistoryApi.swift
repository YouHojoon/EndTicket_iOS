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
    
    func getMainHistory() -> AnyPublisher<[(HistoryType,Int)],AFError>{
        session.request(HistoryRouter.main)
            .publishDecodable(type:GetMainHistroyResponse.self)
            .value()
            .map{
                var result:[(HistoryType,Int)] = []
                result.append((HistoryType.ticket,$0.result?.ticketCount ?? 0))
                result.append((HistoryType.mission,$0.result?.missionCount ?? 0))
                result.append((HistoryType.futureOfMe,$0.result?.dreamCount ?? 0))
                
                return result
            }.eraseToAnyPublisher()
    }
    
    func getTicketHistory(category:Ticket.Category) -> AnyPublisher<[Ticket],AFError>{
        session.request(HistoryRouter.ticket(category))
            .publishDecodable(type:TicketListResponse.self)
            .value()
            .map{
                $0.result?.ticket.map{$0.ticketResponseToTicket()} ?? []
            }.eraseToAnyPublisher()
    }
}

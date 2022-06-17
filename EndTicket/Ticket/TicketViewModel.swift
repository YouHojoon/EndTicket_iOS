//
//  TicketViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import Combine
import SwiftUI

final class TicketViewModel:ObservableObject{
    @Published var tickets:[Ticket] = []
    let isPostTicketSuccess = PassthroughSubject<Bool,Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchTickets(){
        TicketApi.shared.getTickets().receive(on: DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 불러오기 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.tickets = $0
        }).store(in: &subscriptions)
    }
    
    func postTicket(_ ticket: Ticket){
        TicketApi.shared.postTicket(ticket).receive(on:DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 등록 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            guard $0 != nil else{
                self.isPostTicketSuccess.send(false)
                return
            }
            let color = Color(hex:$0!.color)
            self.tickets.append(Ticket(title: $0!.title, category: Ticket.Category(rawValue: $0!.category)!, start: $0!.start, end: $0!.end, color: color, touchCount: $0!.touchCount, currentCount: 0, id: 60606060))
            self.isPostTicketSuccess.send(true)
        }).store(in: &subscriptions)
    }
}

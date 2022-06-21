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
          
            self.tickets.append($0!)
            self.isPostTicketSuccess.send(true)
        }).store(in: &subscriptions)
    }
    
    func deleteTicket(_ ticket: Ticket){
        TicketApi.shared.deleteTicket(ticket).receive(on: DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 삭제 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            if $0{
                let index = self.tickets.firstIndex(where: {$0.id == ticket.id})!
                self.tickets.remove(at: index)
            }
        }).store(in: &subscriptions)
    }
}

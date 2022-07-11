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
    @Published public private(set) var tickets:[Ticket] = []
    @Published public private(set) var preferTicket:Ticket? = nil
    
    let isSuccessPostTicket = PassthroughSubject<Bool,Never>()
    let isSuccessModifyTicket = PassthroughSubject<Bool,Never>()
    let isSuccessDeleteTicket = PassthroughSubject<Bool,Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchTickets(){
        if tickets.isEmpty{
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
                self.isSuccessPostTicket.send(false)
                return
            }
            
            self.tickets.append($0!)
            self.isSuccessPostTicket.send(true)
        }).store(in: &subscriptions)
    }
    func deleteTicket(id: Int){
        TicketApi.shared.deleteTicket(id:id).receive(on: DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 삭제 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.isSuccessDeleteTicket.send($0)
            if $0{
                let index = self.tickets.firstIndex(where: {$0.id == id})!
                withAnimation{                    
                    self.tickets.remove(at: index)
                }
            }
        }).store(in: &subscriptions)
    }
    func modifyTicket(_ ticket: Ticket){
        TicketApi.shared.modifyTicket(ticket).receive(on:DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 수정 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            guard $0 != nil else{
                self.isSuccessModifyTicket.send(false)
                return
            }
            let index = self.tickets.firstIndex{$0.id == ticket.id}!
            self.tickets[index] = $0!
            self.isSuccessModifyTicket.send(true)
        }).store(in: &subscriptions)
    }
    
    func touchTicket(id: Int){
        TicketApi.shared.touchTicket(id: id).receive(on: DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 터치 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            if $0{
                let index = self.tickets.firstIndex(where: {$0.id == id})!
                if self.tickets[index].currentCount == self.tickets[index].touchCount {
                    _ = withAnimation{
                        self.tickets.remove(at: index)
                    }
                }
                else{
                    self.tickets[index].currentCount+=1
                }
            }
        }).store(in: &subscriptions)
    }
    
    func cancelTouchTicket(id:Int){
        TicketApi.shared.canelTouchTicket(id: id).receive(on:DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("ticket 터치 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            if $0{
                let index = self.tickets.firstIndex(where: {$0.id == id})!
                self.tickets[index].currentCount-=1
            }
        }).store(in: &subscriptions)
    }
    
    func getPreferTicket(){
        TicketApi.shared.getPreferTicket().receive(on: DispatchQueue.main).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("추천 티켓 get 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.preferTicket = $0
        }).store(in: &subscriptions)
    }
}

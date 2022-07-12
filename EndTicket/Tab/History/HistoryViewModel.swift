//
//  HistoryViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/12.
//

import Foundation
import Combine
import SwiftUI

final class HistoryViewModel: ObservableObject{
    @Published public private(set) var mainHistory: [(HistoryType, Int)] = []
    @Published public private(set) var ticketHistories: [Ticket] = []
    private var subscriptions = Set<AnyCancellable>()
    
    
    func getMainHistoryAmount(type:HistoryType) -> Int{
        let history = mainHistory.first{(historyType, _) in
            type == historyType
        }
        guard let history = history else {
            return 0
        }
        return history.1
    }
    
    func fetchMainHistory(){
        HistoryApi.shared.getMainHistory().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("메인 기록 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.mainHistory = $0
        }).store(in: &subscriptions)
    }
    func fetchTicketHistory(category: Ticket.Category){
        HistoryApi.shared.getTicketHistory(category: category).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("티켓 기록 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.ticketHistories = $0
        }).store(in: &subscriptions)
    }
}

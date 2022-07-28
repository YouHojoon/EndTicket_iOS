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
    @Published public private(set) var mainHistory: MainHistory? = nil
    @Published public private(set) var ticketHistories: [Ticket] = []
    @Published public private(set) var imagineHistories: [Imagine] = []
    @Published public private(set) var missionHistories: [Mission] = []
    private var subscriptions = Set<AnyCancellable>()
    
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
    func fetchImagineHistory(){
        HistoryApi.shared.getImagineHistory().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("상상하기 기록 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.imagineHistories = $0
        }).store(in: &subscriptions)
    }
//    func fetchMissionHistory(){
//        HistoryApi.shared.getMissionHistory().sink(receiveCompletion: {
//            switch $0{
//            case .finished:
//                break
//            case .failure(let error):
//                print("주간 미션 기록 조회 실패 : \(error.localizedDescription)")
//            }
//        }, receiveValue: {
//            self.missionHistories = $0
//        }).store(in: &subscriptions)
//    }
}

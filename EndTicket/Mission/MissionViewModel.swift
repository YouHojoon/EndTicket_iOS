//
//  MissionViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
import Combine
final class MissionViewModel: ObservableObject{
    @Published public private(set) var mission: Mission?
    
    private var subscriptions = Set<AnyCancellable>()
    func fetchMission(){
        MissionApi.shared.getMission().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("미션 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.mission = $0
        }).store(in: &subscriptions)
    }
}

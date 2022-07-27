//
//  MissionApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
import Combine
import Alamofire
final class MissionApi: BaseApi{
    static let shared = MissionApi()
    private init() {
        super.init(needInterceptor: true)
    }
    
    func getMission() -> AnyPublisher<Mission?, AFError>{
        return session.request(MissionRouter.getMission)
            .publishDecodable(type:MissionResponse.self)
            .value()
            .map{
                $0.result
            }.eraseToAnyPublisher()
    }
}

//
//  FutureOfMeApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/07.
//

import Foundation
import Alamofire
import Combine

final class FutureOfMeApi: BaseApi{
    static let shared = FutureOfMeApi()
    private override init(needInterceptor: Bool = true) {
        super.init(needInterceptor: needInterceptor)
    }
    
    func getFutureOfMe() -> AnyPublisher<FutureOfMe?, AFError>{
        return session.request(FutureOfMeRouter.getFutureOfMe)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:GetFutureOfMeResponse.self)
            .value()
            .map{
                $0.result
            }.eraseToAnyPublisher()
    }
    func postFutureOfMeSubject(_ subject: String) -> AnyPublisher<Bool, AFError>{
        return session.request(FutureOfMeRouter.postFutureOfMeSubject(subject))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostFutureOfMeSubjectResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
}

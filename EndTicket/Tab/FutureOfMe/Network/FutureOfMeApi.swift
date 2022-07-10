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
    func getImagines() -> AnyPublisher<[Imagine], AFError>{
        return session.request(FutureOfMeRouter.getImagine)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:GetImagineResponse.self)
            .value()
            .map{
                guard let imagineResponses = $0.result?.dream else{
                    return []
                }
                return imagineResponses.map{$0.imagineResponseToImagine()}
            }.eraseToAnyPublisher()
    }
    func postImagine(_ imagine: Imagine) -> AnyPublisher<Imagine?, AFError>{
        return session.request(FutureOfMeRouter.postImagine(imagine))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:PostImagineResponse.self)
            .value()
            .map{
                $0.result?.imagineResponseToImagine()
            }
            .eraseToAnyPublisher()
    }
    func touchImagine(id:Int)-> AnyPublisher<Bool, AFError>{
        return session.request(FutureOfMeRouter.touchImagine(id))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:TouchImagineResponse.self)
            .value()
            .map{
                $0.isSuccess
            }
            .eraseToAnyPublisher()
    }
}

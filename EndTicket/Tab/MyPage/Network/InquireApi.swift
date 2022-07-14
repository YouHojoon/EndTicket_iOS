//
//  InquireApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import Combine
import Alamofire

final class InquireApi: BaseApi{
    static let shared =  InquireApi()
    private init(){
        super.init()
    }
    
    func inquire(_ text: String) -> AnyPublisher<Bool, AFError>{
        return session.request(InquireRouter.inquire(text))
            .validate(statusCode: 200..<300)
            .publishDecodable(type:InquireResponse.self)
            .value()
            .map{
                $0.isSuccess
            }.eraseToAnyPublisher()
    }
}

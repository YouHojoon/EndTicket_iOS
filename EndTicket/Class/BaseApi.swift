//
//  BaseApi.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/14.
//

import Foundation
import Alamofire

//MARK: - 기본 API 규격
class BaseApi{
    let session: Session
    init(){
        session = Session(interceptor:AuthInterceptor())
    }
}

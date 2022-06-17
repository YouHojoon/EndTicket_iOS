//
//  RouterProtocol.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
import Alamofire

protocol BaseRouter: URLRequestConvertible{
    var endPoint:String {get}
    var parameters:Parameters {get}
    var method: HTTPMethod {get}
}

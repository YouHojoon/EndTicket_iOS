//
//  protocol.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/16.
//

import Foundation
protocol BaseResponse: Codable{
    associatedtype Result where Result: Codable
    var isSuccess: Bool {get}
    var code: Int {get}
    var message: String {get}
    var result: Result {get}
}

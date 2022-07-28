//
//  MissionRouter.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/13.
//

import Foundation
import Alamofire
enum MissionRouter: BaseRouter{
    case getMission
    
    var method: HTTPMethod{
        return .get
    }
    var parameters: Parameters{
        return Parameters()
    }
    var endPoint: String{
        return "mission"
    }
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: EndTicketApp.baseUrl)!.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}

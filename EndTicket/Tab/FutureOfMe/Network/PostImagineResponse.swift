//
//  PostImagineResponse.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/09.
//

import Foundation
import SwiftUI
struct PostImagineResponse:BaseResponse{
    let isSuccess: Bool
    let message: String
    let code: Int
    let result: Result?
    
    typealias Result = ImagineResponse
}

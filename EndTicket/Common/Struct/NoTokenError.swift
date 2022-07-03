//
//  File.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/24.
//

import Foundation
struct NoTokenError: Error, LocalizedError{
    let errorDescription: String = "키체인에 토큰이 존재하지 않습니다."
}

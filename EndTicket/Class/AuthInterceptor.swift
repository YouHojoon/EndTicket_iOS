//
//  AuthInterceptor.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/14.
//

import Foundation
import Alamofire

final class AuthInterceptor: Interceptor{
    override func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if urlRequest.url!.absoluteString.contains("login"){
            completion(.success(urlRequest))
        }
        
        urlRequest.headers.add(name: "Content-Type", value: "application/json; charset=UTF-8")
        guard let token = KeyChainManager.readInKeyChain(key: "token") else{
            completion(.failure(NoTokenError()))
            return
        }
  
        urlRequest.headers.add(name: "x-access-token", value: token)
        completion(.success(urlRequest))
    }
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        super.retry(request, for: session, dueTo: error, completion: completion)
    }
}

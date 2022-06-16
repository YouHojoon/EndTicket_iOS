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
        urlRequest.headers.add(name: "x-access-token", value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJzdWIiOjEsImlhdCI6MTY1NTE2MTYzNCwiZXhwIjoxNjg2NzE5MjM0fQ.go4zOhwNGjNsL9-7G3jfVbbIWgICq1aYw6SBJSFKIQ0")
        completion(.success(urlRequest))
    }
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        super.retry(request, for: session, dueTo: error, completion: completion)
    }
}

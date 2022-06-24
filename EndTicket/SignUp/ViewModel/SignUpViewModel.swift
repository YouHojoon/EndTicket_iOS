//
//  SignUpViewModle.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/03.
//

import Foundation
import SwiftUI
import Combine
final class SignUpViewModel:ObservableObject{
    lazy var isNicknameStatisfied:AnyPublisher<Bool, Never> = $nickname.map{$0.range(of: self.nicknameFormat,options:.regularExpression) != nil}.eraseToAnyPublisher()
    @Published var nickname = ""
    @Published var isSuccessSignUp = false
   
    private let nicknameFormat = "^[A-Za-z0-9가-힣]{3,8}$"
    private var subscriptions = Set<AnyCancellable>()
    
    func signUp(){
        SignUpApi
            .shared.signUp(nickname: nickname)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    self.isSuccessSignUp = true
                    break
                case .failure(let error):
                    print("닉네임 등록 실패 : \(error.localizedDescription)")
                    self.isSuccessSignUp = false
                }
            }, receiveValue: {_ in
              
            })
            .store(in: &subscriptions)
    }
}

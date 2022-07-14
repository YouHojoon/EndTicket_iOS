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
    @Published var isSuccessSignUpNickname = false
    @Published var isSuccessSignUpCharacter = false
    @Published var isSuccessDeleteUser = false
    private let nicknameFormat = "^[A-Za-z0-9가-힣]{3,8}$"
    private var subscriptions = Set<AnyCancellable>()
    
    func signUpNickname(){
        SignUpApi
            .shared.signUpNickname(nickname)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("닉네임 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                self.isSuccessSignUpNickname = $0
                UserDefaults.standard.set(self.nickname,forKey: "nickname")
            })
            .store(in: &subscriptions)
    }
    
    func signUpCharacter(_ character: Character){
        SignUpApi
            .shared.signUpCharacter(character)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("캐릭터 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                self.isSuccessSignUpCharacter = $0
            })
            .store(in: &subscriptions)
    }
    
    func deleteUser(){
        SignUpApi.shared.deleteUser()
            .sink(receiveCompletion:{
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("유저 삭제 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                self.isSuccessDeleteUser = true
            })
    }
}

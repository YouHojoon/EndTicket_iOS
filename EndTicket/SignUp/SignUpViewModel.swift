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
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("닉네임 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                if $0{
                    self.isSuccessSignUpNickname = EssentialToSignIn.nickname.save(data: self.nickname)
                }
                else{
                    self.isSuccessSignUpNickname = false
                }
                
            })
            .store(in: &subscriptions)
    }
    
    func signUpCharacter(_ character: Character){
        SignUpApi
            .shared.signUpCharacter(character)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("캐릭터 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                guard let imageUrl = $0 else{
                    self.isSuccessSignUpCharacter = false
                    return
                }
                EssentialToSignIn.imageUrl.save(data: imageUrl)
                self.isSuccessSignUpCharacter = true
            })
            .store(in: &subscriptions)
    }
}

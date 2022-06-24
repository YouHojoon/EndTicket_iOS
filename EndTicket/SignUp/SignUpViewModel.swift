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
    private let nicknameFormat = "^[A-Za-z0-9가-힣]{3,8}$"
    @Published var nickname = ""
    lazy var isNicknameStatisfied:AnyPublisher<Bool, Never> = $nickname.map{$0.range(of: self.nicknameFormat,options:.regularExpression) != nil}.eraseToAnyPublisher()
}

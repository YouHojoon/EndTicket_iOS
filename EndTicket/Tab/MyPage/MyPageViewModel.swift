//
//  InquireViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/14.
//

import Foundation
import Combine

final class MyPageViewModel:ObservableObject{
    @Published public private(set) var isSuccessInquire = false
    @Published public private(set) var isSuccessDeleteUser = false
    private var subscriptions = Set<AnyCancellable>()
    func inquire(_ text: String){
        InquireApi.shared.inquire(text).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("문의하기 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.isSuccessInquire = $0
        }).store(in: &subscriptions)
    }
    
    func deleteUser(){
        SignUpApi.shared.deleteUser(text: "")
            .sink(receiveCompletion:{
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("유저 삭제 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                self.isSuccessDeleteUser = $0
            }).store(in: &subscriptions)
    }
}

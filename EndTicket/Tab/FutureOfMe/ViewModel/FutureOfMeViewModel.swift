//
//  ImaginViewModel.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/09.
//

import Foundation
import SwiftUI
import Combine
final class FutureOfMeViewModel:ObservableObject{
    @Published public private(set) var imagines = Imagine.getDummys()
    @Published var futureOfMe: FutureOfMe? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    func toggleIsSuccessed(index:Int){
        imagines[index].isSuccessed .toggle()
    }
    
    func getFutureOfMe(){
        FutureOfMeApi.shared.getFutureOfMe().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("미래의 나 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.futureOfMe = $0
        }).store(in: &subscriptions)
    }
    
    func postFutureOfMeSubject(_ subject: String){
        FutureOfMeApi.shared.postFutureOfMeSubject(subject)
            .sink(receiveCompletion:{
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("미래의 나 제목 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                if $0{
                    self.futureOfMe?.subject = subject
                }
            }).store(in: &subscriptions)
    }
}

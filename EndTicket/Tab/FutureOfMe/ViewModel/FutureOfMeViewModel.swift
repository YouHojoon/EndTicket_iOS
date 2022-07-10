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
    @Published public private(set) var imagines:[Imagine] = []
    @Published public private(set) var futureOfMe: FutureOfMe? = nil
    let isSuccessPostImagine = PassthroughSubject<Bool, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    func toggleImagineIsSuccessed(id:Int){
        let index = imagines.firstIndex{$0.id == id}!
        FutureOfMeApi.shared.touchImagine(id: id)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("상상해보기 터치 실패 : \(error.localizedDescription)")
                }
            }
                  , receiveValue: {
                if $0{
                    self.imagines[index].isSuccess.toggle()
                }
                
            }).store(in: &subscriptions)
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
    func fetchImagines(){
        FutureOfMeApi.shared.getImagines()
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("상상해보기 조회 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                self.imagines = $0
            }).store(in: &subscriptions)
    }
    func postImagine(_ imagine: Imagine){
        FutureOfMeApi.shared.postImagine(imagine)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("상상해보기 등록 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                guard let imagine = $0 else{
                    self.isSuccessPostImagine.send(false)
                    return
                }
                self.isSuccessPostImagine.send(true)
                self.imagines.append(imagine)
            }).store(in: &subscriptions)
    }
}

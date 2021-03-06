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
    
    let fetchImagineTrigger = PassthroughSubject<Void, Never>()
    let isSuccessPostImagine = PassthroughSubject<Bool, Never>()
    let isSuccessModifyImagine = PassthroughSubject<Bool, Never>()
    let isSuccessDeleteImagine = PassthroughSubject<(Bool), Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    func touchImagine(id:Int){
        let index = imagines.firstIndex{$0.id == id}!
        FutureOfMeApi.shared.touchImagine(id: id).sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("상상해보기 터치 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            if $0{
                self.imagines.remove(at: index)
                self.fetchImagineTrigger.send(())
                self.fetchFutureOfMe()
            }
        }).store(in: &subscriptions)
    }
    func fetchFutureOfMe(){
        FutureOfMeApi.shared.getFutureOfMe().sink(receiveCompletion: {
            switch $0{
            case .finished:
                break
            case .failure(let error):
                print("미래의 나 조회 실패 : \(error.localizedDescription)")
            }
        }, receiveValue: {
            self.futureOfMe = $0
            if let imageUrl = self.futureOfMe?.characterImageUrl{
                EssentialToSignIn.imageUrl.save(data:imageUrl.absoluteString)
            }
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
                self.fetchImagineTrigger.send(())
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
                self.imagines.append(imagine)
                self.fetchImagineTrigger.send(())
                self.isSuccessPostImagine.send(true)
            }).store(in: &subscriptions)
    }
    func modifyImagine(_ imagine: Imagine){
        FutureOfMeApi.shared.modifyImagine(imagine)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("상상해보기 수정 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                guard let imagine = $0 else{
                    self.isSuccessModifyImagine.send(false)
                    return
                }
                let index = self.imagines.firstIndex{$0.id == imagine.id}!
                self.imagines[index] = imagine
                self.isSuccessModifyImagine.send(true)
                self.fetchImagineTrigger.send(())
            })
            .store(in: &subscriptions)
    }
    func deleteImagine(id: Int){
        FutureOfMeApi.shared.deleteImagine(id: id)
            .sink(receiveCompletion: {
                switch $0{
                case .finished:
                    break
                case .failure(let error):
                    print("상상해보기 삭제 실패 : \(error.localizedDescription)")
                }
            }, receiveValue: {
                if $0{
                    let index = self.imagines.firstIndex{$0.id == id}!
                    self.imagines.remove(at: index)
                    self.isSuccessDeleteImagine.send(true)
                    self.isSuccessPostImagine.send(true)
                }
                else{
                    self.isSuccessDeleteImagine.send(false)
                }
            }).store(in: &subscriptions)
    }
}

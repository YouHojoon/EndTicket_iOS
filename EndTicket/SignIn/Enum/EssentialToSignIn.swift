//
//  EssentialToSignIn.swift
//  EndTicket
//
//  Created by 유호준 on 2022/07/15.
//

import Foundation
enum EssentialToSignIn: CaseIterable{
    case token
    case nickname
    case socialType
    case id
    case email
    
    var saved:String?{
        switch self {
        case .token:
            return KeyChainManager.readInKeyChain(key: key)
        default:
            return UserDefaults.standard.string(forKey: key)
        }
    }
    
    func save(data:String) -> Bool{
        switch self {
        case .token:
            return KeyChainManager.saveInKeyChain(key: key, data: data)
        default:
            UserDefaults.standard.setValue(data, forKey: key)
            return true
        }
    }
    
    static func isCanSignIn() -> Bool{
        let index = EssentialToSignIn.allCases.firstIndex(of: .socialType)!
        var cases = EssentialToSignIn.allCases
        cases.remove(at: index)
        
        return cases.reduce(true){$0 && $1.saved != nil}
    }
    
    static func removeAllOfSaved(){
        EssentialToSignIn.allCases.forEach{$0.removeSaved()}
    }
    
    private func removeSaved(){
        switch self {
        case .token:
            _ = KeyChainManager.deleteInKeyChain(key: key)
        default:
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    private var key: String{
        switch self {
        case .token:
            return "token"
        case .nickname:
            return "nickname"
        case .socialType:
            return "socialType"
        case .id:
            return "id"
        case .email:
            return "remail"
        }
    }
}

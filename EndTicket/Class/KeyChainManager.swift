//
//  KeyChainManager.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/01.
//

import Foundation
import AuthenticationServices

//MARK: - Apple 로그인 키체인 저장을 도우기 위한 클래스
final class KeyChainManager{
    
    static func getBaseQuery(key: String) -> [CFString:Any]{
        return [kSecClass: kSecClassGenericPassword,
          kSecAttrService: Bundle.main.bundleIdentifier!,
          kSecAttrAccount: key,
        ]
    }
    
    
    static func deleteInKeyChain(key:String) -> Bool{
        let query = getBaseQuery(key: key)
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == noErr else{
            return false
        }
        
        return true
    }
    static func saveInKeyChain(key:String, data: String) -> Bool{
        var query = getBaseQuery(key: key)
        let encodedData = data.data(using: .utf8)!
        let status:OSStatus
        
        if let _ = readInKeyChain(key: key){
            status = SecItemUpdate(query as CFDictionary, [kSecValueData: encodedData] as CFDictionary)
        }
        else{
            query[kSecValueData] = encodedData
            status = SecItemAdd(query as CFDictionary, nil)
        }
        

        guard status == noErr else{
            return false
        }
        return true
    }
    static func readInKeyChain(key:String) -> String?{
        var query = getBaseQuery(key: key)
        query[kSecMatchLimit] = kSecMatchLimitOne
        query[kSecReturnAttributes] = kCFBooleanTrue
        query[kSecReturnData] = kCFBooleanTrue
            
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else{
            return nil
        }
        guard status == noErr else{
            return nil
        }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let data = existingItem[kSecValueData as String] as? Data,
              let dataString = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return dataString
    }
    static func saveUserInKeyChain(credential:ASAuthorizationAppleIDCredential) -> Bool{
        return saveInKeyChain(key: "userIdentifier", data: credential.user)
    }
    static func readUserInKeyChain() -> String?{
        return readInKeyChain(key: "userIdentifier")
    }
    static func deleteUserInKeyChain() -> Bool{
        return deleteInKeyChain(key: "userIdentifier")
    }
    
}

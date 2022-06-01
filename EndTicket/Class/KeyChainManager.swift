//
//  KeyChainManager.swift
//  EndTicket
//
//  Created by 유호준 on 2022/06/01.
//

import Foundation
import AuthenticationServices

//MARK: - Apple 로그인 키체인 저장을 도우기 위한 클래스
class KeyChainManager{
    static private let baseQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                            kSecAttrService: Bundle.main.bundleIdentifier!,
                            kSecAttrAccount: "userIdentifier",
                                ]
    
    static func readUserInKeyChain() -> String?{
        var query = baseQuery
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
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8)
        else {
            return nil
        }
        
        return password
    }
    
    static func saveUserInKeyChain(credential:ASAuthorizationAppleIDCredential) -> Bool{
        var query = baseQuery
        let encodedUser = credential.user.data(using: .utf8)!
        let status:OSStatus
        
        if let _ = readUserInKeyChain(){
            status = SecItemUpdate(query as CFDictionary, [kSecValueData: encodedUser] as CFDictionary)
        }
        else{
            query[kSecValueData] = encodedUser
            status = SecItemAdd(query as CFDictionary, nil)
        }
        
        guard status == noErr else{
            return false
        }
        return true
    }
}

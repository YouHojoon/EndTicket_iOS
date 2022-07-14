import AuthenticationServices
import Foundation

//MARK: - Apple 로그인을 위한 클래스
final class ASAuthorizationControllerDelgateImpl: NSObject, ASAuthorizationControllerDelegate{
    private let completion: ((String?) -> Void)?
    
    init(completion: ((String?) -> Void)? = nil){
        self.completion = completion
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential{
            guard KeyChainManager.saveUserInKeyChain(credential: credential) else {
                completion?(nil)
                return
            }
            guard let idToken = credential.identityToken else{
                completion?(nil)
                return
            }
            completion?(String(data:idToken,encoding: .utf8))
        }
        else{
            completion?(nil)
        }
    }
}

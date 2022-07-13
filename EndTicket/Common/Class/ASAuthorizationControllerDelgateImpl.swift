import AuthenticationServices
import Foundation

//MARK: - Apple 로그인을 위한 클래스
final class ASAuthorizationControllerDelgateImpl: NSObject, ASAuthorizationControllerDelegate{
    private let completion: ((Bool) -> Void)?
    
    init(completion: ((Bool) -> Void)? = nil){
        self.completion = completion
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential{
            print(String(data: credential.identityToken!, encoding: .utf8)!)
            completion?(KeyChainManager.saveUserInKeyChain(credential: credential))
        }
        else{
            completion?(false)
        }
    }
}

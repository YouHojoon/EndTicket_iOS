//
//  EndTicketApp.swift
//  EndTicket
//
//  Created by 유호준 on 2022/05/27.
//
import FirebaseCore
import FirebaseMessaging
import SwiftUI
import GoogleSignIn
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct EndTicketApp: App {
    private let googleClientId: String
    static let baseUrl = "https://dev.endticket.shop/"
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init(){
        guard let cetentialListFile = Bundle.main.url(forResource: "Credential", withExtension: "plist"), let credentialList = NSDictionary(contentsOf: cetentialListFile) else{
            fatalError("SNS Login을 위한 Credential.plist가 존재하지 않습니다.")
        }
        guard let googleClientId = credentialList["GOOGLE_CLIENT_ID"] as? String, let kakaoClientId = credentialList["KAKAO_CLIENT_ID"] as? String else{
            fatalError("SNS Login을 위한 클라이언트 아이디가 존재하지 않습니다.")
        }
        self.googleClientId = googleClientId
        KakaoSDK.initSDK(appKey: kakaoClientId)
    }
    
    var body: some Scene {
        WindowGroup {
            SignInView()
                .onOpenURL{
                    if AuthApi.isKakaoTalkLoginUrl($0){
                        AuthController.handleOpenUrl(url: $0)
                    }
                    else{
                        GIDSignIn.sharedInstance.handle($0)
                    }
                }
                .environmentObject(SignInViewModel(googleClientId: googleClientId))
        }
    }
}




class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if #available(iOS 10.0, *){
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions){_, _ in
            }
        }
        else{
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
      
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("device token \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
}



extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("AppDelgate - 파이어베이스 토큰 수신")
        print("AppDelgate - Firebase registration token: \(String(describing: fcmToken))")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print("will present: userInfo: ", userInfo)
        let categori = notification.request.content.categoryIdentifier
        print("categori : \(categori)")
        completionHandler([.badge, .banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("didReceive : userInfo: ", userInfo)
        print("pressed \(response.actionIdentifier)")
        completionHandler()
    }
}





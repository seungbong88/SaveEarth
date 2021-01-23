//
//  AppDelegate.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/24.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit
import Firebase
import KakaoSDKCommon
import KakaoSDKAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initialize()
        
        return true
    }

    private func initialize() {
        // Firebase 시작
        FirebaseApp.configure()
        
        // kakao API 시작
        KakaoSDKCommon.initSDK(appKey: Common.KAKAO_NATIVE_KEY)
        
        // 푸시 알림 등록
        initPush()
    }
    
    // 앱 스킴을 이용해 앱이 실행될 경우 호출
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("[AppDelegate - open url] 앱 실행되었음, url : \(url.absoluteString)")
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("[Push Notification] device token 등록 완료")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("[Push Notification] device token fail")
    }
    
    // 포그라운드에서 푸시알림 수신 시 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 포그라운드에서도 푸시얼럿, 사운드 되도록 설정
        completionHandler([.alert, .sound])
    }
    
    // 푸시알림 선택 시 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let aps = userInfo["aps"] as? [String : Any] {
            if let alert = aps["alert"] as? [String : Any] {
                let title: String = alert["title"] as? String ?? ""
                let message: String = alert["body"] as? String ?? ""
                Common.showToast(title: title, message: message)
            }
        }
        
        completionHandler()
    }
    
    // MARK: Push Notification Delegate
    private func initPush() {
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = false // FCM 토큰 자동갱신 방지
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    // MARK: Firebase Messaging Delegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registeration token : \(String(describing: fcmToken))")
        
        let dataDic: [String: String] = ["token" : fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDic)
        
        
        // FCM 토큰 처리
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }
    }
    
}

extension AppDelegate {
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

//
//  LoginViewController.swift
//  SaveEarth
//
//  Created by seungbong on 2021/01/24.
//  Copyright © 2021 한승희. All rights reserved.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        databaseTest()
    }
    
    private func databaseTest() {
        SessionManager.userData = UserInfo(id: "seungbong8.8@gmail.com", name: "한승희")
        if let id = SessionManager.userData?.id, let name = SessionManager.userData?.name {
            SessionManager.appDelegate.databaseRef?.child("테스트계정임다").setValue(["email": id])
        }
    }

    @IBAction func clickedKakaoLogin(_ sender: Any) {
        if AuthApi.isKakaoTalkLoginAvailable() {
            AuthApi.shared.loginWithKakaoTalk(completion: { (OauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("kakao login success, OToken: \(String(describing: OauthToken))")
                }
            })
        } else {
            print("카카오톡 설치 안되어있음")
        }
    }
}

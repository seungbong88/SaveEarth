//
//  LeftViewController.swift
//  SaveEarth
//
//  Created by seungbong on 2021/01/15.
//  Copyright © 2021 한승희. All rights reserved.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKTemplate
import KakaoSDKLink

class LeftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func clickedInviteButton(_ sender: Any) {
        let title = "피드 메시지"
        let description = "피드 메시지 예제"

        let feedTemplateJsonStringData =
            """
            {
                "object_type": "feed",
                "content": {
                    "title": "딸기 치즈 케익",
                    "description": "#케익 #딸기 #삼평동 #카페 #분위기 #소개팅",
                    "image_url": "http://mud-kage.kakao.co.kr/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png",
                    "link": {
                        "mobile_web_url": "https://developers.kakao.com",
                        "web_url": "https://developers.kakao.com"
                    }
                },
                "social": {
                    "comment_count": 45,
                    "like_count": 286,
                    "shared_count": 845
                },
                "buttons": [
                    {
                        "title": "웹으로 보기",
                        "link": {
                            "mobile_web_url": "https://developers.kakao.com",
                            "web_url": "https://developers.kakao.com"
                        }
                    },
                    {
                        "title": "앱으로 보기",
                        "link": {
                            "android_execution_params": "key1=value1&key2=value2",
                            "ios_execution_params": "key1=value1&key2=value2"
                        }
                    }
                ]
            }
            """.data(using: .utf8)!
        
        if let templatable = try? SdkJSONDecoder.custom.decode(FeedTemplate.self, from: feedTemplateJsonStringData) {
            LinkApi.shared.defaultLink(templatable: templatable) {(linkResult, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("defaultLink() success.")

                    if let linkResult = linkResult {
                        UIApplication.shared.open(linkResult.url, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
}

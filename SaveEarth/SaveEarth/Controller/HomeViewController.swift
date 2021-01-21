//
//  HomeViewController.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/24.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var savedWasteTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateWastTime),
                                               name: Common.N_UPDATE_MAIN_USERINFO,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showNoti),
                                               name: NSNotification.Name(rawValue: "FCMToken"),
                                               object: nil)
        
        // 임시 로그인 처리
        SessionManager.userData = UserInfo(id: "seungbong8.8@gmail.com", name: "한승희")
    }
    
    @objc private func updateWastTime(_ notification: Notification) {
        if let userInfo = notification.object as? UserInfo {
            savedWasteTimeLabel.text = "\(userInfo.totalSavedTime())"
        }
    }
    
    @objc private func showNoti(_ notification: Notification) {
        if let resDic = notification.userInfo as? [String : String] {
            print(resDic)
        }
    }
    @IBAction func clickedEarthButton(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "PopupVC") {
            present(vc, animated: true, completion: nil)
        }
    }
}



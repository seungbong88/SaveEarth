//
//  HomeViewController.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/24.
//  Copyright © 2020 한승희. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var SavedWasteTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editWasteTime),
                                               name: NSNotification.Name(rawValue: "Noti_EditWasteTime"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showNoti),
                                               name: NSNotification.Name(rawValue: "FCMToken"),
                                               object: nil)
    }
    
    @objc private func editWasteTime(_ notification: Notification) {
        if let wasteInfo = notification.object as? WasteInfo {
            SavedWasteTimeLabel.text = String(wasteInfo.totalRotTime)
        }
    }
    
    @objc private func showNoti(_ notification: Notification) {
        if let resDic = notification.userInfo as? [String : String] {
            print(resDic)
        }
    }
}



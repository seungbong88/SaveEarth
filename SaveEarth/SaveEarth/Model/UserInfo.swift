//
//  UserInfo.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/25.
//  Copyright © 2020 한승희. All rights reserved.
//

import Foundation

class UserInfo {
    var id: String?
    var name: String?
    var totalWasteList: [EnrolledWasteInfo] = []
    
    init(id: String, name: String, savedWaste: [EnrolledWasteInfo] = []) {
        self.id = id
        self.name = name
        self.totalWasteList = savedWaste
    }
    
    func enroll(enrolledWaste: EnrolledWasteInfo) {
        totalWasteList.append(enrolledWaste)
        NotificationCenter.default.post(name: Common.N_UPDATE_MAIN_USERINFO, object: self)
    }
    
    func totalSavedTime() -> Int {
        var totalTime = 0
        for enrolledWaste in totalWasteList {
            totalTime += enrolledWaste.totalRotTime()
        }
        return totalTime
    }
}

//
//  SaveWastInfo.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/25.
//  Copyright © 2020 한승희. All rights reserved.
//

import Foundation
import UIKit

class EnrolledWasteInfo {
    
    /// [종류 : 개수] 한 쌍
    struct WastePair {
        var kinds: Waste?           // 쓰레기 타입
        var count: Int = 0          // 개수
    }
    
    var image: UIImage?             // 등록 사진
    var registerDate: Date?       // 등록 날짜
    var wastePairList: [WastePair] = [] // 등록 쓰레기 리스트

    init() {
        
    }
    
    init(image: UIImage, date: Date) {
        self.image = image
        self.registerDate = date
    }
    
    func addWastePair(type: Common.WasteType, count: Int) {
        let newPair = WastePair(kinds: Waste(type: type), count: count)
        wastePairList.append(newPair)
    }
    
    func totalRotTime() -> Int {
        var totalTime = 0
        for wastePair in wastePairList {
            let rotTime = wastePair.kinds?.rotTime ?? 0
            totalTime += rotTime * wastePair.count
        }
        return totalTime
    }
    
}

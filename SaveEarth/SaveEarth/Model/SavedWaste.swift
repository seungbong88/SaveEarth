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
    
    struct SavedWasteInfo {
        var kinds: WasteType?       // 쓰레기 타입
        var count: Int = 0          // 개수
    }
    
    var image: UIImage?             // 등록 사진
    var regesterDate: String?       // 등록 날짜
    var wasteList: [SavedWasteInfo] = [] // 등록 쓰레기 리스트

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    
    init() { }
    
    init(image: UIImage, kinds: WasteType, count: Int) {
        self.image = image
    }
    
    func addWaste(type: WasteType, count: Int) {
        wasteList.append(SavedWasteInfo(kinds: type, count: count))
    }
    
    func totalRotTime() -> Int {
        var totalTime = 0
        for savedWaste in wasteList {
            let rotTime = savedWaste.kinds?.rotTime ?? 0
            totalTime += rotTime * savedWaste.count
        }
        return totalTime
    }
    
}

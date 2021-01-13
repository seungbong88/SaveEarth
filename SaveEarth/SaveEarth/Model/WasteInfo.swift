//
//  WasteSaver.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/26.
//  Copyright © 2020 한승희. All rights reserved.
//

import Foundation
import UIKit

// 절약한 쓰레기 정보
class WasteInfo {
    
    var count: Int = 0
    var type: WasteType
    var image: UIImage
    var registeredDate: String = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    init(savedImage: UIImage, wasteType: WasteType, wasteCount: Int) {
        self.image = savedImage
        self.type = wasteType
        self.count = wasteCount
        self.registeredDate = dateFormatter.string(from: Date())
    }
    
    var totalRotTime: Int {
        return count * type.rotTime
    }
    
}

//
//  WasteType.swift
//  SaveEarth
//
//  Created by seungbong on 2021/01/17.
//  Copyright © 2021 한승희. All rights reserved.
//

import Foundation

class Waste {

    var type: Common.WasteType?
    var name: String = ""
    var rotTime: Int = 0
    
    init(type: Common.WasteType) {
        self.type = type
        self.name = type.name
        self.rotTime = type.rotTime
    }

    func numOfType() -> Int {
        return Common.WasteType.allCases.count
    }
}

//
//  SaveWastInfo.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/25.
//  Copyright © 2020 한승희. All rights reserved.
//

import Foundation
import UIKit

class SaveWastInfo {
    var image: UIImage?
    var kinds: GarbageType?
    var count: Int = 0
    var regesterDate: String?
    
    init(image: UIImage, kinds: GarbageType, count: Int) {
        self.image = image
    }
}

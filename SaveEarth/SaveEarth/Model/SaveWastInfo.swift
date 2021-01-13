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
    var kinds: WasteType?
    var count: Int = 0
    var regesterDate: String?
    
    init(image: UIImage, kinds: WasteType, count: Int) {
        self.image = image
    }
}

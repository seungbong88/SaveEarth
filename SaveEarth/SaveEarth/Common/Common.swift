//
//  Common.swift
//  SaveEarth
//
//  Created by seunghee on 2021/01/14.
//  Copyright © 2021 한승희. All rights reserved.
//

import Foundation
import UIKit

class Common {
    
    static func showToast(message: String) {
        var view = UIView(frame: CGRect(x: 100, y: 100, width: 300, height: 5))
        view.backgroundColor = .blue
        
        UIApplication.shared.delegate?.window??.backgroundColor = .blue
    }
}

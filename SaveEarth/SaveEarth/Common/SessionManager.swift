//
//  SessionManager.swift
//  SaveEarth
//
//  Created by seungbong on 2021/01/15.
//  Copyright © 2021 한승희. All rights reserved.
//

import Foundation
import UIKit

/* 세션이 유지되는 동안 함께 유지되는 데이터 */
class SessionManager {
    static var userData: UserInfo?
    static var appDelegate = UIApplication.shared.delegate as! AppDelegate
}

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
    
    static let KAKAO_NATIVE_KEY = "1675ee6c272433dfba29a38b0baca7fa"
    
    static func showToast(title: String, message: String) {
        print("title: \(title), message: \(message)")
    }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }
    
    // MARK:- Notification Name
    static let N_UPDATE_MAIN_USERINFO = Notification.Name("UPDATE_MAIN_USERINFO")
    
}

extension Common {
    
    // 쓰레기 종류 enum
    enum WasteType: Int, CaseIterable {
        case plasticBag = 0     // 비닐봉지
        case plasticTakeOutCup  // 일회용 테이크웃잔
        case plasticBottle      // 플라스틱 병
        case plasticBottleCap   // 플라스틱 병뚜껑
        case plasticStraw       // 빨대
        case styrofoamBox       // 스티로폼 상자
        case paperCup           // 종이컵
        case paperBox           // 종이 상자
        case aluminumCan        // 알루미늄 캔
        case toothbrush         // 칫솔
        case woodenChopstick    // 나무젓가락
        case andSoOn            // 기타
        
        var name: String {
            switch self {
            case .plasticBag: return "비닐봉지"
            case .plasticTakeOutCup: return "일회용 테이크웃잔"
            case .plasticBottle: return "플라스틱 병"
            case .plasticBottleCap: return "플라스틱 병뚜껑"
            case .plasticStraw: return "빨대"
            case .styrofoamBox: return "스티로폼 상자"
            case .paperCup: return "종이컵"
            case .paperBox: return "종이 상자"
            case .aluminumCan: return "알루미늄 캔"
            case .toothbrush: return "칫솔"
            case .woodenChopstick: return "나무젓가락"
            case .andSoOn: return "기타"
            }
        }
        
        var rotTime: Int {
            switch self {
            case .plasticBag: return 20
            case .plasticTakeOutCup:   return 30
            case .plasticBottle: return 500
            case .plasticBottleCap: return 30
            case .plasticStraw: return 200
            case .styrofoamBox: return 500
            case .paperCup: return 20
            case .paperBox: return 1
            case .woodenChopstick: return 10
            case .aluminumCan: return 100
            case .toothbrush: return 100
            case .andSoOn: return 0
            }
        }
    }
}

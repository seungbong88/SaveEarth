//
//  GarbageType.swift
//  SaveEarth
//
//  Created by seungbong on 2020/10/25.
//  Copyright © 2020 한승희. All rights reserved.
//

import Foundation


enum GarbageType: Int, CaseIterable {
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
    
    // 해당 종류의 쓰레기가 썩는데 걸리는 시간
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
}

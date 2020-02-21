//
//  MicroDust.swift
//  OneLineWeatherEx
//
//  Created by AmebaHead on 28/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

struct MicroDust {
    var seoul:Int?
    var busan:Int?
    var daegu:Int?
    var incheon:Int?
    var gwangju:Int?
    var daejeon:Int?
    var ulsan:Int?
    var gyeonggi:Int?
    var gangwon:Int?
    var chungbuk:Int?
    var chungnam:Int?
    var jeonbuk:Int?
    var jeonnam:Int?
    var gyeongbuk:Int?
    var gyeongnam:Int?
    var jeju:Int?
    var sejong:Int?
    
    internal func getMicroDust(지역: String) -> Int? {
        switch 지역 {
        case "서울":
            return seoul
        case "부산":
            return busan
        case "대구":
            return daegu
        case "인천":
            return incheon
        case "광주":
            return gwangju
        case "대전":
            return daejeon
        case "울산":
            return ulsan
        case "경기":
            return gyeonggi
        case "충북":
            return chungbuk
        case "충남":
            return chungnam
        case "전북":
            return jeonbuk
        case "전남":
            return jeonnam
        case "경북":
            return gyeongbuk
        case "경남":
            return gyeongnam
        case "제주":
            return jeju
        case "세종":
            return sejong
            
        default:
            return nil
        }
    }
    

    internal func evaluateMicroDust(지역: String) -> String {
        if let value = self.getMicroDust(지역: 지역) {
            switch value {
            case 0..<31:
                return "좋음"
            case 32..<81:
                return "보통"
            case 82..<151:
                return "나쁨"
            case 152..<10000:
                return "매우나쁨"
                
            default:
                return "데이터없음"
            }
        }
        
        return "데이터없음"
    }
}

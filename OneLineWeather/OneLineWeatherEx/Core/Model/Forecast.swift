//
//  Forecast.swift
//  OneLineWeatherEx
//
//  Created by Jun soo Song on 15/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

struct Forecast {
    // 하늘상태
    var skyType: Int? = nil
    // 강수상태
    var rainType: Int? = nil
    // 습도
    var humidity: Int? = nil
    // 기온
    var temperature: Double? = nil
}

extension Forecast {
    var 날씨: 날씨상태 {
        if let rainCode = self.rainType {
            if rainCode != 0 {
                switch rainCode {
                case 1:
                    return .비
                case 2:
                    return .비눈
                case 3:
                    return .눈
                case 4:
                    return .소나기
                    
                default:
                    return .데이터없음
                }
            }else {
                if let skyCode = self.skyType {
                    switch skyCode {
                    case 1:
                        return .맑음
                    case 3:
                        return .구름많음
                    case 4:
                        return .흐림
                        
                    default:
                        return .데이터없음
                    }
                }
            }
        }
        
        return .데이터없음
    }
}

enum 날씨상태: String {
    case 맑음 = "맑음"
    case 구름많음 = "구름많음"
    case 흐림 = "흐림"
    case 비 = "비"
    case 비눈 = "비눈"
    case 눈 = "눈"
    case 소나기 = "소나기"
    case 데이터없음 = "데이터없음"
}





























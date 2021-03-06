//
//  OneLineWeather+Util.swift
//  OneLineWeather
//
//  Created by Jun soo Song on 09/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

// LCC DFS 좌표변환 ( code : PosXY(위경도->좌표, lat_X:위도,  lng_Y:경도), PosLatLon(좌표->위경도,  lat_X:x, lng_Y:y) )
enum PosMode {
    case PosXY
    case PosLanLon
}

struct Position {
    public var lat: Double
    public var lon: Double
    
    public var x: Int
    public var y: Int
}

class OneLineWeatherUtil {
    // Refer: https://gist.github.com/fronteer-kr/14d7f779d52a21ac2f16
    static func convertPosition(mode: PosMode, lat_X: Double, lng_Y: Double) -> Position {
        let RE = 6371.00877 // 지구 반경(km)
        let GRID = 5.0 // 격자 간격(km)
        let SLAT1 = 30.0 // 투영 위도1(degree)
        let SLAT2 = 60.0 // 투영 위도2(degree)
        let OLON = 126.0 // 기준점 경도(degree)
        let OLAT = 38.0 // 기준점 위도(degree)
        let XO:Double = 43 // 기준점 X좌표(GRID)
        let YO:Double = 136 // 기1준점 Y좌표(GRID)

        let DEGRAD = Double.pi / 180.0
        let RADDEG = 180.0 / Double.pi
        
        let re = RE / GRID
        let slat1 = SLAT1 * DEGRAD
        let slat2 = SLAT2 * DEGRAD
        let olon = OLON * DEGRAD
        let olat = OLAT * DEGRAD
        
        var sn = tan(Double.pi * 0.25 + slat2 * 0.5) / tan(Double.pi * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        var sf = tan(Double.pi * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        var ro = tan(Double.pi * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        var rs = Position(lat: 0, lon: 0, x: 0, y: 0)
        
        if mode == PosMode.PosXY {
            rs.lat = lat_X
            rs.lon = lng_Y
            var ra = tan(Double.pi * 0.25 + (lat_X) * DEGRAD * 0.5)
            ra = re * sf / pow(ra, sn)
            var theta = lng_Y * DEGRAD - olon
            if theta > Double.pi {
                theta -= 2.0 * Double.pi
            }
            if theta < -Double.pi {
                theta += 2.0 * Double.pi
            }
            
            theta *= sn
            rs.x = Int(floor(ra * sin(theta) + XO + 0.5))
            rs.y = Int(floor(ro - ra * cos(theta) + YO + 0.5))
        }
        else {
            rs.x = Int(lat_X)
            rs.y = Int(lng_Y)
            let xn = lat_X - XO
            let yn = ro - lng_Y + YO
            var ra = sqrt(xn * xn + yn * yn)
            if (sn < 0.0) {
                ra = -ra
            }
            var alat = pow((re * sf / ra), (1.0 / sn))
            alat = 2.0 * atan(alat) - Double.pi * 0.5
            
            var theta = 0.0
            if (abs(xn) <= 0.0) {
                theta = 0.0
            }
            else {
                if (abs(yn) <= 0.0) {
                    theta = Double.pi * 0.5
                    if (xn < 0.0) {
                        theta = -theta
                    }
                }
                else {
                    theta = atan2(xn, yn)
                }
            }
            let alon = theta / sn + olon
            rs.lat = alat * RADDEG
            rs.lon = alon * RADDEG
        }
        return rs
    }
}

extension Int {
    func formatBaseTimeStr() -> String {
        if self < 0 || self > 24 {return "0000"}
        
        let time = self
        if time > 9 {
            return "\(time)00"
        }
        else {
            return "0\(time)00"
        }
    }
}

extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentHour() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        return Int(dateFormatter.string(from: Date())) ?? 0
    }
}







































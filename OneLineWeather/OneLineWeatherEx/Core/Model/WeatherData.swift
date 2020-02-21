//
//  WeatherData.swift
//  OneLineWeatherEx
//
//  Created by Jun soo Song on 15/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var response: WeatherResponse
}

struct WeatherResponse: Codable {
    var body: WeatherBody
}

struct WeatherBody: Codable {
    var items: WeatherItems
}

struct WeatherItems: Codable {
    var item: [WeatherItem]
}

struct WeatherItem: CustomStringConvertible, Codable {
    var baseDate: Int
//    var baseTime: Int
    var category: String
    var fcstDate: Int
    var fcstValue: Double
    var nx: Int
    var ny: Int
    
    var description: String {
        return "baseDate: \(baseDate) category: \(category) fcstDate: \(fcstDate) fcstValue: \(fcstValue) nx: \(nx) ny: \(ny)"
    }
}





















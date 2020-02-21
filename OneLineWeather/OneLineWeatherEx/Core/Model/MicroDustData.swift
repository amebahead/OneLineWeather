//
//  MicroDustData.swift
//  OneLineWeatherEx
//
//  Created by AmebaHead on 28/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation

struct MicroDustData: Codable {
    var response: MicroDustResponse
}

struct MicroDustResponse: Codable {
    var header: MicroDustHeader
    
    private enum CodingKeys: String, CodingKey {
        case header
    }
}

struct MicroDustHeader: Codable {
//    var resultCode: String
    var resultMsg: String
    
    private enum CodingKeys: String, CodingKey {
        case resultMsg
    }
}


/*
struct MicroDustResponse: Codable {
    var body: MicroDustBody
}

struct MicroDustBody: Codable {
    var items: MicroDustItems
}

struct MicroDustItems: Codable {
    var item: MicroDustItem
}

struct MicroDustItem: CustomStringConvertible, Codable {
//    var dataTime: String
//    var itemCode: String
//    var dataGubun: String
    var dataGubun: String
    /*
    var seoul: String
    var busan: String
    var daegu: String
    var incheon: String
    var gwangju: String
    var daejeon: String
    var ulsan: String
    var gyeonggi: String
    var gangwon: String
    var chungbuk: String
    var chungnam: String
    var jeonbuk: String
    var jeonnam: String
    var gyeongbuk: String
    var gyeongnam: String
    var jeju: String
    var sejong: String
    */
    
    var description: String {
//        return "dataTime: \(dataTime) itemCode: \(itemCode) dataGubun: \(dataGubun) seoul: \(seoul) busan: \(busan) daegu: \(daegu) incheon: \(incheon) gwangju: \(gwangju) daejeon: \(daejeon) ulsan: \(ulsan) gyeonggi: \(gyeonggi) gangwon: \(gangwon) chungbuk: \(chungbuk) chungnam: \(chungnam) jeonbuk: \(jeonbuk) jeonnam: \(jeonnam) gyeongbuk: \(gyeongbuk) jeju: \(jeju) sejong: \(sejong)"
        
        return ""
    }
}
*/

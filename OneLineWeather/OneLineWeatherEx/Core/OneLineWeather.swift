//
//  OneLineWeather.swift
//  OneLineWeather
//
//  Created by Jun soo Song on 07/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import Foundation
import Alamofire
import XMLParsing
import SWXMLHash

class Weather {
    
    internal func getWeather(x: Int, y: Int, callBack: @escaping ((_ forecast: Forecast)->Void)) {
        let baseDate = Date.getCurrentDate()
        let posX = x
        let posY = y
        let pageNo = 1
        
        let currentTime = Date.getCurrentHour()
        let baseTime = BaseTimeList().seekTime(value: currentTime).formatBaseTimeStr()
        
        let req = self.generateWeatherUrl(baseDate, baseTime, posX, posY, pageNo)
        Alamofire.request(req).responseJSON { (res) in
            let statusCode = res.response?.statusCode
            
            switch res.result {
            case .success:
//                debugPrint(res.result.value)
                
                if let data = res.data {
                    let forecast = self.parseJsonData(data: data)
//                    debugPrint(forecast)
                    
                    callBack(forecast)
                }
            case .failure(let error):
                print("\(String(describing: statusCode))")
                print(error)
            }
        }
    }
    
    internal func getMicroDust(callBack: @escaping ((_ microDust: MicroDust)->Void)) {
        let req = self.generateDustUrl()
        Alamofire.request(req).responseString { (res) in
            let statusCode = res.response?.statusCode
                        
                switch res.result {
                case .success:
                    
                    if let data = res.data {
                        let microDust = self.parseXmlData(data: data)
                        callBack(microDust)
                    }
                case .failure(let error):
                    print("\(String(describing: statusCode))")
                    print(error)
                }
        }
    }
}


// MARK: - Function for Weather
extension Weather {
    // http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=temp&base_date=20151201&base_time=0500&nx=60&ny=127&numOfRows=10&pageNo=1&_type=json
    fileprivate func generateWeatherUrl(_ baseDate: String, _ baseTime: String, _ posX: Int, _ posY: Int, _ pageNo: Int) -> String {
        let _url = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?"
        let _serviceKey = "serviceKey=\(OneLineWeatherConfig.shared.API_KEY)&"
        let _baseDate = "base_date=\(baseDate)&"
        let _baseTime = "base_time=\(baseTime)&"
        let _posX = "nx=\(posX)&"
        let _posY = "ny=\(posY)&"
        let _others = "numOfRows=10&pageNo=\(pageNo)&_type=json"
        
        let requestUrl = _url + _serviceKey + _baseDate + _baseTime + _posX + _posY + _others
        print(requestUrl)
        
        return requestUrl
    }
    
    fileprivate func parseJsonData(data: Data) -> Forecast {
        var forecast = Forecast()
        do {
            let weatherDatas = try JSONDecoder().decode(WeatherData.self, from: data)
//            debugPrint(weatherDatas)
            
            let items = weatherDatas.response.body.items.item
            for item in items {
                switch item.category {
                case "SKY":
                    forecast.skyType = Int(item.fcstValue)
                    
                case "PTY":
                    forecast.rainType = Int(item.fcstValue)
                    
                case "T3H":
                    forecast.temperature = item.fcstValue
                    
                case "REH":
                    forecast.humidity = Int(item.fcstValue)
                    
                default:
                    break
                }
            }
        } catch let error {
            debugPrint("## erorr ##")
            print(error.localizedDescription)
        }
        
        return forecast
    }
}

// MARK: - Function for MicroDust
extension Weather {
    // http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst?serviceKey=temp&numOfRows=1&pageNo=1&itemCode=PM10&dataGubun=HOUR&searchCondition=WEEK
    fileprivate func generateDustUrl() -> String {
        let _url = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst?"
        let _serviceKey = "serviceKey=\(OneLineWeatherConfig.shared.API_KEY)&"
        let _others = "numOfRows=1&pageNo=1&"
        let _itemCode = "itemCode=PM10&"
        let _dataGubun = "dataGubun=HOUR&"
        let _searchCondition = "searchCondition=WEEK"
        
        let requestUrl = _url + _serviceKey + _others + _itemCode + _dataGubun + _searchCondition
        print(requestUrl)
        
        return requestUrl
    }
    
    fileprivate func parseXmlData(data: Data) -> MicroDust {
        /*
        do {
            let microDustDatas = try XMLDecoder().decode(MicroDustData.self, from: data)
            debugPrint(microDustDatas)
            
            let item = microDustDatas.response.header.resultMsg
            print(item)
        }
        catch let error {
           debugPrint("## erorr ##")
           print(error.localizedDescription)
       }
       */
        
        var microDust = MicroDust()
        let xml = SWXMLHash.parse(data)
        let dustItem = xml["response"]["body"]["items"]["item"]
        
        if let seoul = dustItem["seoul"].element?.text {
            microDust.seoul = Int(seoul)
        }
        if let busan = dustItem["busan"].element?.text {
            microDust.busan = Int(busan)
        }
        if let daegu = dustItem["daegu"].element?.text {
            microDust.daegu = Int(daegu)
        }
        if let incheon = dustItem["incheon"].element?.text {
            microDust.incheon = Int(incheon)
        }
        if let gwangju = dustItem["gwangju"].element?.text {
            microDust.gwangju = Int(gwangju)
        }
        if let daejeon = dustItem["daejeon"].element?.text {
            microDust.daejeon = Int(daejeon)
        }
        if let ulsan = dustItem["ulsan"].element?.text {
            microDust.ulsan = Int(ulsan)
        }
        if let gyeonggi = dustItem["gyeonggi"].element?.text {
            microDust.gyeonggi = Int(gyeonggi)
        }
        if let gangwon = dustItem["gangwon"].element?.text {
            microDust.gangwon = Int(gangwon)
        }
        if let chungbuk = dustItem["chungbuk"].element?.text {
            microDust.chungbuk = Int(chungbuk)
        }
        if let chungnam = dustItem["chungnam"].element?.text {
            microDust.chungnam = Int(chungnam)
        }
        if let jeonbuk = dustItem["jeonbuk"].element?.text {
            microDust.jeonbuk = Int(jeonbuk)
        }
        if let jeonnam = dustItem["jeonnam"].element?.text {
            microDust.jeonnam = Int(jeonnam)
        }
        if let gyeongnam = dustItem["gyeongnam"].element?.text {
            microDust.gyeongnam = Int(gyeongnam)
        }
        if let jeju = dustItem["jeju"].element?.text {
            microDust.jeju = Int(jeju)
        }
        if let sejong = dustItem["sejong"].element?.text {
            microDust.sejong = Int(sejong)
        }
        
        return microDust
    }
}
































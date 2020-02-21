//
//  OneLineWeatherView.swift
//  OneLineWeatherEx
//
//  Created by Jun soo Song on 15/01/2020.
//  Copyright © 2020 amebahead. All rights reserved.
//

import UIKit

class OneLineWeatherView: UIView {

    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var microDustLabel: UILabel!
    
    // For test
    var saveX: Int!
    var saveY: Int!
    var save지역: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Deinit: \(String(describing: type(of: self)))")
    }
    
    private func initialize(){
        guard let view = loadViewFromNib() else { return }
        view.frame = CGRect(x: 0, y: 0, width: 423, height: 205)
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OneLineWeather", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        self.weatherImage.image = nil
        self.temperLabel.text = nil
        self.weatherLabel.text = nil
        self.humidityLabel.text = nil
        self.microDustLabel.text = nil
        
        self.getWeatherDust(x: self.saveX, y: self.saveY, 지역: self.save지역)
    }
}

extension OneLineWeatherView {
    func getWeatherDust(x: Int, y: Int, 지역: String) {
        self.saveX = x
        self.saveY = y
        self.save지역 = 지역
        
        let weather =  Weather()
        weather.getWeather(x: x, y: y) { (forecast) in
            debugPrint(forecast)
            
            self.weatherLabel.text = "\(forecast.날씨)"
            self.temperLabel.text = forecast.temperature != nil ? "\(forecast.temperature!)℃" : "데이터없음"
            self.humidityLabel.text = forecast.humidity != nil ? "\(forecast.humidity!)%" : "데이터없음"
            
            var mainWeather = ""
            var subWeather = Date.getCurrentHour() < 18 ? "_day" : "_night"
            switch forecast.날씨 {
            case .맑음:
                mainWeather = "sunny"
            case .구름많음:
                mainWeather = "cloudy"
            case .흐림:
                mainWeather = "cloudy"
                subWeather = "_bad"
            case .비:
                mainWeather = "rainny"
            case .비눈:
                mainWeather = "rainny"
                subWeather = "_cloudy"
            case .눈:
                mainWeather = "snowy"
                subWeather = ""
            case .소나기:
                mainWeather = "rainny"
                subWeather = ""
                
            default:
                mainWeather = ""
                subWeather = ""
            }
            
            let resultWeather = mainWeather + subWeather
            self.weatherImage.image = UIImage(named: "\(resultWeather)")
        }
        
        weather.getMicroDust { (microDust) in
            /*
            if let value = microDust.getMicroDust(지역: 지역) {
                self.microDustLabel.text = "\(value)"
            }
            else {
                self.microDustLabel.text = "데이터없음"
            }
            */
            self.microDustLabel.text = microDust.evaluateMicroDust(지역: 지역)
        }
    }
}





























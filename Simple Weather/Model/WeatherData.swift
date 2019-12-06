//
//  WeatherData.swift
//  Simple Weather
//
//  Created by Stanley Tseng on 2019/12/4.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var name: String // city name
    var main: [String: Double] // temp, temp_max, temp_min, humidity
    var wind: [String: Double] // wind speed
    var weather: [WeatherInfo]
    
}

struct WeatherInfo: Codable {
    var id: Double
    var main: String
    var description: String // Describe the weather
    var icon: String
}

var locationChinese = ["請選擇地點", "基隆", "宜蘭", "南港", "板橋", "台北", "桃園", "大溪", "竹北", "新竹", "苗栗", "台中", "南投", "彰化",  "雲林", "嘉義", "東山", "台南", "高雄", "花蓮", "台東","鳳山", "屏東", "澎湖"]

var locationID = ["", "6724654", "1674197", "7552914",  "1670029", "1668341", "1667905", "1668467", "1677112", "1675107", "1671971", "1668399", "1671564","1679136", "1665194", "1678836", "1669401","1668352", "7280289","1674502", "1668295", "1673816", "1670479", "1670651"]

var locationWorld = ["請選擇地點", "東京", "首爾", "倫敦"]

var locationWorldID = ["", "1850147", "1835848", "1006984"]

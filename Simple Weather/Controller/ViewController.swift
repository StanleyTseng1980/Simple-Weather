//
//  ViewController.swift
//  Simple Weather
//
//  Created by Stanley Tseng on 2019/12/4.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import UIKit

var grade = "" // 目前只能用全域變數來回傳Cell城市選單，未來學會更好的方式時再修改

struct APIKeys {
    static let apikey = "06bc3033d025cad9d33193018423c22d" // 輸入在OpenWeatherMap申請的API key
}

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var currentTem: UILabel!
    @IBOutlet weak var maxTem: UILabel!
    @IBOutlet weak var minTem: UILabel!
    @IBOutlet weak var bodyTem: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var lbCityName: UILabel!
    @IBOutlet weak var lbExCityName: UILabel!
    @IBOutlet weak var textfieldInquire: UITextField!
    @IBOutlet weak var btnStartInquire: UIButton!
    @IBOutlet weak var btnOpenInquireWindows: UIButton!
    @IBOutlet weak var btnCommonCityList: UIButton!
    
    var weatherInfo: Weather?
    var transformDescription: String = ""
    var timer: Timer?
    var cityName: String?
    var imageName: String? = "few clouds"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隱藏查詢城市介面
        closeInquireWindowsAction()
        
        // 透過textFieldShouldReturn定義按下return按鈕
        textfieldInquire.delegate = self
        
        // 一開始的預設地點為台北Taipei
        getWeatherData(getCityName: "Taipei")
        
        // 利用全域變數回傳cell的程式名稱
        textfieldInquire.text! = grade
        if textfieldInquire.text! == "Taipei" {
            getWeatherData(getCityName: "Taipei")
        } else {
            getWeatherData(getCityName: textfieldInquire.text!)
        }
        
        // 設定目前時間與日期
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let time = formatter.string(from: now)
            self.currentTime.text = time
        })
    }
    
    // 點擊空白處Text Field輸入鍵盤可消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 透過JSON抓取OpenWeatherMap的天氣資訊
    func getWeatherData(getCityName:String) {
        
        if let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(getCityName)&APPID=\(APIKeys.apikey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            //            print("Enter URL")
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let weather = try? decoder.decode(Weather.self, from: data) {
                    self.weatherInfo = weather
                    //                    print("did get")
                    
                    let currentTemInFan = self.weatherInfo?.main["temp"]
                    let currentTemInCel = (currentTemInFan!-273.15)
                    let maxTemInFan = self.weatherInfo?.main["temp_max"]
                    let maxTemInCel = (maxTemInFan!-273.15)
                    let minTemInFan = self.weatherInfo?.main["temp_min"]
                    let mixTemInCel = (minTemInFan!-273.15)
                    DispatchQueue.main.async {
                        self.locationName.text = self.weatherInfo?.name
                        self.currentTem.text = String(format: "%.1f", currentTemInCel) + "℃"
                        self.maxTem.text = String(format: "%.1f", maxTemInCel) + "℃"
                        self.minTem.text = String(format: "%.1f", mixTemInCel) + "℃"
                        self.humidity.text = String(format: "%.1f", (self.weatherInfo?.main["humidity"])!) + "%"
                        self.windSpeed.text = String(format: "%.1f", (self.weatherInfo?.wind["speed"])!) + "m/s"
                        self.weatherDescription.text = self.weatherInfo?.weather[0].description
                        self.descriptionEnglishTransformChinese(description: self.weatherDescription.text!)
                        // print(self.weatherDescription.text!)
                        
                        // 體感溫度轉換公式
                        // 體感溫度 = (1.04 × 溫度) + (0.2 × 水氣壓) — (0.65 × 風速) — 2.7 其中溫度以攝氏為單位、風速以公尺/秒為單位，水氣壓的單位為百帕，計算公式如下:
                        // 水氣壓 = (相對濕度 / 100) × 6.105 × exp[ (17.27 × 溫度) / (237.7 + 溫度) ](其中 e=2.71828) 這個體感溫度公式
                        
                        let waterPressure = (((self.weatherInfo?.main["humidity"])!) / 100.0) * 6.105 * (exp((17.27 * currentTemInCel) / (237.7 + currentTemInCel)))
                        let bodyTem = (1.04 * currentTemInCel) + (0.2 * waterPressure) - (0.65 * (self.weatherInfo?.wind["speed"])!) - 2.7
                        self.bodyTem.text = String(format: "%.1f", bodyTem) + "℃"
                        
                        if self.imageName != self.weatherInfo?.weather[0].description {
                            self.imageName = self.weatherInfo?.weather[0].description ?? ""
                            UIView.transition(with: self.currentWeatherIcon,
                                              duration: 0.75,
                                              options: .transitionCrossDissolve,
                                              animations: { self.currentWeatherIcon.image = UIImage(named: self.imageName ?? "") },
                                              completion: nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    // 設定英文描述轉中文，還有搭配適合的weather Icon
    func descriptionEnglishTransformChinese (description:String) {
        switch description {
        case "broken clouds":
            transformDescription = "少雲"
            backgroundImage.image = UIImage(named: "broken clouds1")
        case "clear sky":
            transformDescription = "晴朗"
            backgroundImage.image = UIImage(named: "clear sky1")
        case "few clouds":
            transformDescription = "晴朗少雲"
            backgroundImage.image = UIImage(named: "few clouds1")
        case "light intensity drizzle":
            transformDescription = "毛毛雨"
            backgroundImage.image = UIImage(named: "light intensity drizzle1")
        case "light rain":
            transformDescription = "小雨"
            backgroundImage.image = UIImage(named: "light rain1")
        case "mist":
            transformDescription = "薄霧"
            backgroundImage.image = UIImage(named: "mist1")
        case "moderate rain":
            transformDescription = "雨量適中"
            backgroundImage.image = UIImage(named: "moderate rain1")
        case "overcast clouds":
            transformDescription = "烏雲密佈"
            backgroundImage.image = UIImage(named: "overcast clouds1")
        case "rain":
            transformDescription = "下雨"
            backgroundImage.image = UIImage(named: "rain1")
        case "scattered clouds":
            transformDescription = "疏雲"
            backgroundImage.image = UIImage(named: "scattered clouds1")
        case "shower rain":
            transformDescription = "陣雨"
            backgroundImage.image = UIImage(named: "shower rain1")
        case "snow":
            transformDescription = "下雪"
            backgroundImage.image = UIImage(named: "snow1")
        case "thunderstorm":
            transformDescription = "雷雨"
            backgroundImage.image = UIImage(named: "thunderstorm1")
        case "heavy intensity rain":
            transformDescription = "大雨"
            backgroundImage.image = UIImage(named: "heavy intensity rain1")
        case "fog":
            transformDescription = "多霧"
            backgroundImage.image = UIImage(named: "fog1")
        case "light snow":
            transformDescription = "飄雪"
            backgroundImage.image = UIImage(named: "light snow1")
        default:
            return
        }
        self.weatherDescription.text! = transformDescription
    }
    
    func openInquireWindowsAction() {
        lbCityName.isHidden = false
        lbExCityName.isHidden = false
        textfieldInquire.isHidden = false
        btnStartInquire.isHidden = false
    }
    
    func closeInquireWindowsAction() {
        lbCityName.isHidden = true
        lbExCityName.isHidden = true
        textfieldInquire.isHidden = true
        btnStartInquire.isHidden = true
    }
    
    // 點擊Return鍵，收回Text Field鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func btnCommonCityListAction(_ sender: Any) {
        
    }
    
    // MARK: - 查詢Button (開啟與關閉查詢介面)
    @IBAction func btnOpenInquireWindowsAction(_ sender: Any) {
        if textfieldInquire.isHidden == true {
            openInquireWindowsAction()
        } else {
            closeInquireWindowsAction()
        }
    }
    
    // 將Text Field輸入的英文城市名存入textfieldInquire.text
    @IBAction func textfieldInputText(_ sender: UITextField) {
        textfieldInquire.text = sender.text!
    }
    
    // 將Text Field輸入的英文城市名與OpenWeatherMap的API網址進行連結的Button
    @IBAction func btnStartInquireAction(_ sender: Any) {
        
        print(textfieldInquire.text!)
        if textfieldInquire.text != nil {
            getWeatherData(getCityName: textfieldInquire.text!)
            closeInquireWindowsAction()
            
            // 輸入完成後，移除Text Field開啟的鍵盤
            UIView.animate(withDuration: 0.3) {
                self.view.endEditing(true)
            }
        }
    }
}

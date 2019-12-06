//
//  CitysTableViewController.swift
//  Simple Weather
//
//  Created by Stanley Tseng on 2019/12/6.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import UIKit

class CitysTableViewController: UITableViewController {
    
    var citys = [
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "台北", cityEnglishName: "Taipei"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "桃園", cityEnglishName: "Taoyuan"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "新竹", cityEnglishName: "Hsinchu"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "苗栗", cityEnglishName: "Miaoli"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "台中", cityEnglishName: "Taichung"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "南投", cityEnglishName: "Nantou"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "彰化", cityEnglishName: "Chang-hua"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "雲林", cityEnglishName: "Yunlin"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "嘉義", cityEnglishName: "Jiayi Shi"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "台南", cityEnglishName: "Tainan"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "高雄", cityEnglishName: "Kaohsiung"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "屏東", cityEnglishName: "Pingtung"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "台東", cityEnglishName: "Taitung"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "花蓮", cityEnglishName: "Hualien"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "宜蘭", cityEnglishName: "Yilan, TW"),
        Citys(countryChineseName: "台灣", conutryEnglishName: "Taiwan", cityChineseName: "澎湖", cityEnglishName: "Penghu"),
        
        Citys(countryChineseName: "美國", conutryEnglishName: "US", cityChineseName: "洛杉磯", cityEnglishName: "Los Angeles"),
        Citys(countryChineseName: "英國", conutryEnglishName: "UK", cityChineseName: "倫敦", cityEnglishName: "London"),
        Citys(countryChineseName: "美國", conutryEnglishName: "US", cityChineseName: "紐約", cityEnglishName: "New York"),
        Citys(countryChineseName: "法國", conutryEnglishName: "France", cityChineseName: "巴黎", cityEnglishName: "Paris"),
        Citys(countryChineseName: "義大利", conutryEnglishName: "Italy", cityChineseName: "羅馬", cityEnglishName: "Roma"),
        
        
        Citys(countryChineseName: "新加坡", conutryEnglishName: "Singapore", cityChineseName: "新加坡", cityEnglishName: "Singapore"),
        Citys(countryChineseName: "韓國", conutryEnglishName: "Korea", cityChineseName: "首爾", cityEnglishName: "Seoul"),
        Citys(countryChineseName: "日本", conutryEnglishName: "Japan", cityChineseName: "東京", cityEnglishName: "Tokyo"),
        Citys(countryChineseName: "泰國", conutryEnglishName: "Thailand", cityChineseName: "曼谷", cityEnglishName: "Bangkok"),
        Citys(countryChineseName: "香港", conutryEnglishName: "Hong Kong", cityChineseName: "香港", cityEnglishName: "Hong Kong"),
        Citys(countryChineseName: "印尼", conutryEnglishName: "Indonesia", cityChineseName: "雅加達", cityEnglishName: "Jakarta"),
        Citys(countryChineseName: "越南", conutryEnglishName: "Vietnam", cityChineseName: "河内", cityEnglishName: "Ha Noi"),
        
        
        Citys(countryChineseName: "奧地利", conutryEnglishName: "Austria", cityChineseName: "維也納", cityEnglishName: "Vienna"),
        Citys(countryChineseName: "澳洲", conutryEnglishName: "Australia", cityChineseName: "墨爾本", cityEnglishName: "Melbourne"),
        Citys(countryChineseName: "日本", conutryEnglishName: "Japan", cityChineseName: "大阪", cityEnglishName: "Osaka"),
        Citys(countryChineseName: "加拿大", conutryEnglishName: "Canada", cityChineseName: "卡加利", cityEnglishName: "Calgary"),
        Citys(countryChineseName: "澳洲", conutryEnglishName: "Australia", cityChineseName: "雪梨", cityEnglishName: "Sydney"),
        Citys(countryChineseName: "加拿大", conutryEnglishName: "Canada", cityChineseName: "溫哥華", cityEnglishName: "Vancouver"),
        Citys(countryChineseName: "加拿大", conutryEnglishName: "Canada", cityChineseName: "多倫多", cityEnglishName: "Toronto"),
        Citys(countryChineseName: "丹麥", conutryEnglishName: "Denmark", cityChineseName: "哥本哈根", cityEnglishName: "Copenhagen"),
        Citys(countryChineseName: "澳洲", conutryEnglishName: "Australia", cityChineseName: "阿德萊德", cityEnglishName: "Adelaide"),]
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "citysCell", for: indexPath) as! CitysTableViewCell
        
        // Configure the cell...
        let city = citys[indexPath.row]
        cell.countryChineseName.text = city.countryChineseName
        cell.conutryEnglishName.text = city.conutryEnglishName
        cell.cityChineseName.text = city.cityChineseName
        cell.cityEnglishName.text = city.cityEnglishName

        return cell
    }
}


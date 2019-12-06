//
//  CitysTableViewCell.swift
//  Simple Weather
//
//  Created by Stanley Tseng on 2019/12/6.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import UIKit

class CitysTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryChineseName: UILabel!
    @IBOutlet weak var conutryEnglishName: UILabel!
    @IBOutlet weak var cityChineseName: UILabel!
    @IBOutlet weak var cityEnglishName: UILabel!
    @IBOutlet weak var cellCatchCityName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        grade = cityEnglishName.text! // 使用全域變數作為回傳城市名稱
    }
}

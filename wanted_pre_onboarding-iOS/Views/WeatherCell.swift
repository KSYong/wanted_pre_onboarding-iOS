//
//  TableViewCell.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!    // API에서 받아온 날씨 아이콘을 표시할 이미지 뷰
    @IBOutlet weak var cityNameLabel: UILabel!  // 도시 이름 표시할 라벨
    @IBOutlet weak var currentTemperatureLabel: UILabel!    // 도시의 현재 기온 표시할 라벨
    @IBOutlet weak var currentHumidityLabel: UILabel!   // 도시의 현재 습도 표시할 라벨
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

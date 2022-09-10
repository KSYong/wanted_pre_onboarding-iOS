//
//  WeatherData.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import UIKit

struct WeatherData {
    let latitude: Double    // 위도
    let longitude: Double   // 경도
    
    var weatherImage: UIImage?
    
    let cityName: String
    var currentTemperature: String?
    var currentHumidity: String?
}


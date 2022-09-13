//
//  WeatherData.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import UIKit

// MARK: - 위도 경도 및 도시 이름 등을 포함하는 날씨 정보 구조체
struct WeatherData {
    let latitude: Double    // 위도
    let longitude: Double   // 경도
    
    var weatherDetail: DetailData?
    
    var weatherImage: UIImage?
    
    let cityName: String
    var currentTemperature: String?
    var currentHumidity: String?
}


// MARK: - requestURL 후 반환받은 JSON 정보를 파싱한 결과물이 저장되는 구조체
struct DetailData: Codable {
    let coord: Coord
    let weather: Weather
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// Clouds
struct Clouds: Codable {
    let all: Int
}

// Coord
struct Coord: Codable {
    let lon, lat: Double
}

// Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

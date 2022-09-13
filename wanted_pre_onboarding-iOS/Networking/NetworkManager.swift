//
//  NetworkManager.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getWeatherJsonData(latitude lat: Double, longitude lon: Double, completionHandler: @escaping (DetailData?, Error?) -> Void) {
        guard let url = URL(string: "\(WeatherApi.requestURL)&lat=\(lat)&lon=\(lon)&appid=\(Storage.ApiKey)") else {
            print("Error: url 생성 실패")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("Error: url로부터 GET 실패")
                print(error!)
                return
            }
            
            guard let safeData = data else {
                print("Error: data 수신 실패")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request 실패")
                return
            }
            
            completionHandler(self.parseJSON(safeData), error)
        }.resume()
    }
    
    func parseJSON(_ detailData: Data) -> DetailData? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(DetailData.self, from: detailData)
            return decodedData
            
        } catch {
            print("Error: JSON 파일 파싱 실패")
            return nil
        }
    }
}

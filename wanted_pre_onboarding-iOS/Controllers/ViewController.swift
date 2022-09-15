//
//  ViewController.swift
//  wanted_pre_onboarding-iOS
//
//  Created by SEUNGYONG KWON on 2022/09/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    var networkManager = NetworkManager.shared
    var dataManager = DataManager.shared
    
    var weatherData: [WeatherData] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidload 실행")
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        setupData()
    }
    
    // 날씨 데이터 설정
    func setupData() {
        print("setupData 실행")
        dataManager.makeWeatherData()
        weatherData = dataManager.getWeatherData()
        
        for index in 0..<weatherData.count {
            networkManager.getWeatherJsonData(latitude: weatherData[index].latitude, longitude: weatherData[index].longitude) { detailData, error in
                print("컴플리션 핸들러 실행, detialData 가져와짐")
                guard let detailData = detailData else {
                    print("Error: detailData nil")
                    return
                }
                print("파싱 완료된 디테일 데이터 옵셔널 언래핑 완료")
                self.weatherData[index].weatherDetail = detailData
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.getWeatherData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellforRowAt 실행")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        guard let weatherDetail = self.weatherData[indexPath.row].weatherDetail else {
            cell.cityNameLabel.text = self.weatherData[indexPath.row].cityName
            
            return cell
        }
        
        let weatherIcon = weatherDetail.weather?[0].icon
            
        let url = URL(string: "https://openweathermap.org/img/wn/\(weatherIcon!)@2x.png")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            self.weatherData[indexPath.row].weatherImage = UIImage(data: data!)
            
            // UI 변경 처리는 main에서..
            DispatchQueue.main.async {
                cell.weatherIcon.image = self.weatherData[indexPath.row].weatherImage
            }
        }
        
        print(self.weatherData[indexPath.row].cityName)
        cell.cityNameLabel.text = self.weatherData[indexPath.row].cityName
        cell.currentTemperatureLabel.text = "🌡 " + String(weatherDetail.main!.temp!) + "°C"
        cell.currentHumidityLabel.text = "💧 " + String(weatherDetail.main!.humidity!) + "%"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
}



//
//  ViewController.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,IWeather{
 
    
    
    
    
    

    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var tempratureLabel: UILabel!
    
    
    let coreLocation  = CLLocationManager()
    var weatherManager = WeatherManager()
    
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coreLocation.delegate = self
        coreLocation.requestWhenInUseAuthorization()
        coreLocation.requestLocation()
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        weatherManager.delegate = self
        
       
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherManager.dailyList.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = weatherManager.dailyList[indexPath.row]
        let id = data.weather[0].id
        let iconId = weatherManager.getIconId(id: id)
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.dayName.text = weatherManager.dateConverter(date: data.dt )
        cell.dayWeatherIcon.load(url: URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")!)
        cell.dayMax.text = "\(weatherManager.getIntegerPartOfDouble(temp: data.temp.max))° "
        cell.dayMin.text = "\(weatherManager.getIntegerPartOfDouble(temp: data.temp.min))°"
       
        return cell
    }

    func didUpdataWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
           
            self.cityNameLabel.text = weather.name
            self.tempratureLabel.text = "\(self.weatherManager.getIntegerPartOfDouble(temp: weather.temp))°"
            self.weatherIconImage.load(url: URL(string: "https://openweathermap.org/img/wn/\(weather.conditionName)@2x.png")!)
            self.weatherManager.dailyList = weather.daily
            self.forecastTableView.reloadData()
            
           
        }
       
    }

}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, lon: long)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error)
    }
}


 

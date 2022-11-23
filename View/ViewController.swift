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
    var currentAddres = ""
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coreLocation.delegate = self
        checkLocationPermission()
      
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
           
            
            self.tempratureLabel.text = "\(self.weatherManager.getIntegerPartOfDouble(temp: weather.temp))°"
            self.weatherIconImage.load(url: URL(string: "https://openweathermap.org/img/wn/\(weather.conditionName)@2x.png")!)
            self.weatherManager.dailyList = weather.daily
            self.forecastTableView.reloadData()
            
           
        }
       
    }
    
    func checkLocationPermission(){
        switch coreLocation.authorizationStatus{
            
        case .notDetermined:
            coreLocation.requestWhenInUseAuthorization()
        case .restricted:
           showAlert(withTitle: "Error Occured", message: "Location Permission Is Restricted")
        case .denied:
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let settingAction = UIAlertAction(title: "Settings", style: .default){(action) in
                if let url = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(url,options: [:],completionHandler: nil)
                }
            }
            showAlert(withTitle: "Error Occured", message: "Location Permission Is Denied , Please Allow On Settings",actions: [settingAction,cancel])
        case .authorizedAlways , .authorizedWhenInUse:
            coreLocation.startUpdatingLocation()
        @unknown default:
            showAlert(withTitle: "Error", message: "Something went wrong")
        }
    }
    
    
    func showAlert(withTitle title : String?,message :String? , actions : [UIAlertAction] = [ UIAlertAction(title: "Ok", style: .default,handler: nil)]){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach({alert.addAction($0)})
        present(alert,animated: true,completion: nil)
       
    }
    
    func getAddressFromLocation(withLocation location : CLLocation){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                self.showAlert(withTitle: "Error", message: error.localizedDescription)
            }
            else if let address = placemarks{
                for i in address{
                    self.currentAddres = i.administrativeArea ?? "İstanbul"
                    self.cityNameLabel.text = self.currentAddres                }
            }
            
            
        }
    }

}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        if let location = locations.first{
            
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            coreLocation.stopUpdatingLocation()
            getAddressFromLocation(withLocation: location)
            weatherManager.fetchWeather(lat: lat, lon: long)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(withTitle: "Error", message: error.localizedDescription)
    }
}




 

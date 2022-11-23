//
//  WeatherManager.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import Foundation
//
//  WeatherManager.swift
//  Clima
//
//  Created by berat can beduk on 18.11.2022.
//

import Foundation
import CoreLocation
import UIKit


protocol IWeather {
  
    func didUpdataWeather(weather : WeatherModel)
}

struct WeatherManager{
    
    var delegate : IWeather?
    var dailyList : [Daily] = []
    var iconId : String = ""
    
    let wUrl = "https://api.openweathermap.org/data/2.5/onecall?appid=8ddadecc7ae4f56fee73b2b405a63659&units=metric"
    
    func fetchWeather(lat : CLLocationDegrees , lon : CLLocationDegrees){
        
        let urlString = "\(wUrl)&lat=\(lat)&lon=\(lon)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        //create Url
        if let url = URL(string: urlString){
         //create URL Session
            
            let session = URLSession(configuration: .default)
           //give session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error ?? "hata")
                    return
                }
                
                if let safeData = data {
                    if let myWeather = self.parseJson(weatherData: safeData){
                        self.delegate?.didUpdataWeather(weather: myWeather)
                      
                    }
                }

            }
            task.resume()
        }
        

    }
    
    func parseJson(weatherData : Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do{
            //decode data from weather data
            let decodedData = try decoder.decode(WeatherModels.self, from: weatherData)
            
            //let them declare as a variable
            let timezone = decodedData.timezone
            let temp = decodedData.current.temp
            let daily = decodedData.daily
            let weather = decodedData.current.weather
            
           
            // Put them on a model
            let weatherModel = WeatherModel(name: timezone,weather: weather, temp:temp, daily: daily)
            
           
          
            // return the model for using
            return weatherModel
        }catch{
            print(error)
            print("Something went wrong")
            return nil
        }
        
        
    }
    
    func dateConverter(date : Double?) -> String {
        var dayName = ""
        if let day = date {
            let date = Date(timeIntervalSince1970: day)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let convertedDate = dateFormatter.string(from: date)
            dayName = convertedDate
        }
        return dayName
        
    }
    
    func getIntegerPartOfDouble(temp : Double?) -> Int {
        var integerTemp : Int = 0
        
        if let temp {
            let flooredValue = floor(temp)
            let integer = Int(flooredValue)
            integerTemp = integer
         }
        return integerTemp
    }
    
    func getIconId(id : Int) -> String{
        switch id{
                case 200...232:
                    return "11d"
                case 300...321:
                    return "09d"
                case 500...531:
                    return "09d"
                case 600...622:
                    return "13d"
                case 701...781:
                    return "50d"
                case 800:
                    return "01d"
                case 801...804:
                    return "03d"
                default:
                    return "01d"
                }
    }
   
   
    
}

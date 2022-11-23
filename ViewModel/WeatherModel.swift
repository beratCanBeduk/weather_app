//
//  WeatherModel.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import Foundation


struct WeatherModel {
    let name : String
    let weather : [Weather]
    let temp : Double
    let daily : [Daily]
   
    
    
    var tempString : String {
        String(format: "%.f", name)
    }
    var conditionName : String{
        
        switch weather[0].id {
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

//
//  WeatherData.swift
//  openweatherapp
//
//  Created by berat can beduk on 22.11.2022.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)




struct WeatherModels : Codable {
    let timezone : String
    let daily : [Daily]
    let current : Current

}


struct Current: Codable {
    let dt: Int
    let temp: Double
    let weather : [Weather]
}

struct Daily: Codable {

    let temp: Temp
    let dt : Double
    let weather : [Weather]
    
}
// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}


struct Weather: Codable {
    let id: Int
    let icon: String

}

//
//  Forecast.swift
//  URLSessionTestOpenWeatherAPI
//
//  Created by 한유진 on 6/17/24.
//

import Foundation

struct Weather: Codable {
    let weather: String
    let description: String
    let iconCode: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "main"
        case description
        case iconCode = "icon"
    }
}

struct Temperature: Codable {
    let temp: Double
    let humidity: Int
}

struct Forecast: Codable {
    let dateTime: Int
    let temperature: Temperature
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case temperature = "main"
        case weather
    }
}

struct City: Codable {
    let name: String
    let country: String
}

struct Root: Codable {
    let city: City
    let code: String
    let forecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case city
        case code = "cod"
        case forecasts = "list"
    }
}

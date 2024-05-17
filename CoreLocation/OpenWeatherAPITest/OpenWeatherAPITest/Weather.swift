//
//  Weather.swift
//  OpenWeatherAPITest
//
//  Created by 한유진 on 4/4/24.
//

import Foundation

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

struct Root: Codable {
    let weather: [Weather]
    let main: Main
    let dt: Int
    let sys: Sys
}

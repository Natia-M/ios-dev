//
//  Weather.swift
//  lecture20
//
//  Created by naat minasiani on 14/06/2026.
//

import Foundation
struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

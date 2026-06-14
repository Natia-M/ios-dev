//
//  NetworkManager.swift
//  lecture20
//
//  Created by naat minasiani on 14/06/2026.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let apiKey = "059d3dba125df378a05a5b62d3f7565c"
    
    func fetchWeather(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Bad URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No Data", code: 0)))
                }
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}

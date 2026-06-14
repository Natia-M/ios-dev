//
//  WeatherDetailViewController.swift
//  lecture20
//
//  Created by naat minasiani on 14/06/2026.
//
import UIKit

class WeatherDetailViewController: UIViewController {
    
    var city: String?
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label.frame = view.bounds
        label.numberOfLines = 0
        label.textAlignment = .center
        
        view.addSubview(label)
        
        fetchWeather()
    }
    
    func fetchWeather() {
        guard let city = city else { return }
        
        NetworkManager.shared.fetchWeather(city: city) { result in
            
            switch result {
                
            case .success(let data):
                self.label.text = """
                City: \(data.name)
                Temp: \(data.main.temp)°C
                Desc: \(data.weather.first?.description ?? "")
                """
                
            case .failure(let error):
                self.label.text = "Error: \(error.localizedDescription)"
            }
        }
    }
}

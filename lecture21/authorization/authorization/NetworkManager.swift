//
//  NetworkManager.swift
//  authorization
//
//  Created by naat minasiani on 01/07/2026.
//
import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMovie(completion: @escaping (Movie?) -> Void) {
        
    let urlString = "https://www.omdbapi.com/?i=tt3896198&apikey=4e95949"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                
                DispatchQueue.main.async {
                    completion(movie)
                }
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
}


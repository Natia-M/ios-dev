//
//  NetworkManager.swift
//  authorization
//
//  Created by BatumiService on 20/06/2026.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMovie(completion: @escaping (Movie?) -> Void) {
        
        let urlString = "http://www.omdbapi.com/?i=tt3896198&apikey=YOUR_API_KEY"
        
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
let urlString = "https://www.omdbapi.com/?i=tt3896198&apikey=YOUR_API_KEY"

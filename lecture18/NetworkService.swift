//
//  NetworkService.swift
//  lecture18
//
//  Created by naat minasiani on 14/06/2026.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchPosts(completion: @escaping ([Post]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let posts = try? JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts ?? [])
            }
        }.resume()
    }
    
    func fetchComments(postId: Int, completion: @escaping ([Comment]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)/comments")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let comments = try? JSONDecoder().decode([Comment].self, from: data!)
            
            DispatchQueue.main.async {
                completion(comments ?? [])
            }
        }.resume()
    }
}

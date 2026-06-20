//
//  Model.swift
//  authorization
//
//  Created by BatumiService on 20/06/2026.
//

import Foundation
struct Movie: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    let poster: String
    let imdbRating: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case poster = "Poster"
        case imdbRating
    }
}

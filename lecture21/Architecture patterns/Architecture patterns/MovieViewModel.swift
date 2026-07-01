//
//  MovieViewModel.swift
//  Architecture patterns
//
//  Created by naat minasiani on 01/07/2026.
//

import Foundation

class MovieViewModel {
    private var movie: Movie?
    var onUpdate: (() -> Void)?
    func fetchMovie() {
        NetworkManager.shared.fetchMovie { [weak self] movie in
            guard let self = self else { return }
            self.movie = movie
            self.onUpdate?()
        }
    }

    func getTitle() -> String {
        movie?.title ?? ""
    }

    func getRating() -> String {
        "⭐️ \(movie?.imdbRating ?? "")"
    }

    func getGenre() -> String {
        movie?.genre ?? ""
    }

    func getActors() -> String {
        movie?.actors ?? ""
    }

    func getDirector() -> String {
        movie?.director ?? ""
    }

    func getPlot() -> String {
        movie?.plot ?? ""
    }

    func getPosterURL() -> URL? {
        guard let poster = movie?.poster else { return nil }
        return URL(string: poster)
    }
}

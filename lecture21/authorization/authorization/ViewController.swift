//
//  ViewController.swift
//  authorization
//
//  Created by naat minasiani on 01/07/2026.
//

import UIKit
class ViewController: UIViewController {
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()
    let genreLabel = UILabel()
    let actorsLabel = UILabel()
    let directorLabel = UILabel()
    let plotLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchMovie()

    }
    
    func fetchMovie() {

        print("fetchMovie called")

        NetworkManager.shared.fetchMovie { movie in

            guard let movie = movie else {

                print("Movie is nil")

                return

            }

            print(movie.title)

            self.titleLabel.text = movie.title

            self.ratingLabel.text = "⭐️ \(movie.imdbRating)"

            self.genreLabel.text = movie.genre

            self.actorsLabel.text = movie.actors

            self.directorLabel.text = movie.director

            self.plotLabel.text = movie.plot

            if let url = URL(string: movie.poster) {

                self.loadImage(from: url)

            }

        }

    }
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        
        posterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        ratingLabel.textColor = .white
        genreLabel.textColor = .lightGray
        actorsLabel.textColor = .lightGray
        directorLabel.textColor = .lightGray
        
        plotLabel.textColor = .white
        plotLabel.numberOfLines = 0
        
        let stack = UIStackView(arrangedSubviews: [
            posterImageView,
            titleLabel,
            ratingLabel,
            genreLabel,
            actorsLabel,
            directorLabel,
            plotLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

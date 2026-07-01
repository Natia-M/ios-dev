//
//  ViewController.swift
//  Architecture patterns
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

    let viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
        viewModel.fetchMovie()
    }

    func bindViewModel() {

        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }

            self.titleLabel.text = self.viewModel.getTitle()
            self.ratingLabel.text = self.viewModel.getRating()
            self.genreLabel.text = self.viewModel.getGenre()
            self.actorsLabel.text = self.viewModel.getActors()
            self.directorLabel.text = self.viewModel.getDirector()
            self.plotLabel.text = self.viewModel.getPlot()

            if let url = self.viewModel.getPosterURL() {
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

        [titleLabel, ratingLabel, genreLabel, actorsLabel, directorLabel, plotLabel].forEach {
            $0.textColor = .white
        }

        genreLabel.textColor = .lightGray
        actorsLabel.textColor = .lightGray
        directorLabel.textColor = .lightGray

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

//
//  CitiesViewController.swift
//  lecture20
//
//  Created by naat minasiani on 14/06/2026.
//

import UIKit


class CitiesViewController: UIViewController {
    
    var tableView = UITableView()
    let cities = ["Batumi", "Tbilisi", "London", "Paris"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cities"
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = cities[indexPath.row]
        
        let vc = WeatherDetailViewController()
        vc.city = city
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

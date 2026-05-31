//
//  ProductCollectionViewController.swift
//  lecture 17
//
//  Created by naat minasiani on 31/05/2026.
//
import UIKit

class ProductCollectionViewController: UIViewController, UICollectionViewDelegate {
    
    private let totalLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    var products: [Product] = [
        Product(name: "Banana", price: 1.29, image: "banana", quantity: 0),
        Product(name: "Orange", price: 1.99, image: "orange", quantity: 0),
        Product(name: "Capsicum", price: 1.49, image: "capsicum", quantity: 0),
        Product(name: "Broccoli", price: 1.89, image: "broccoli", quantity: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        
        view.addSubview(totalLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        updateTotal()
    }
    
    func updateTotal() {
        let total = products.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
        totalLabel.text = "Total: \(total)$"
    }
}

extension ProductCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ProductCell",
            for: indexPath
        ) as! ProductCell
        
        let product = products[indexPath.row]
        
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "\(product.price)$ /kg"
        cell.quantityLabel.text = "\(product.quantity)"
        cell.imageView.image = UIImage(named: product.image)
        
        cell.onAdd = { [weak self] in
            self?.products[indexPath.row].quantity += 1
            self?.collectionView.reloadItems(at: [indexPath])
            self?.updateTotal()
        }
        
        cell.onMinus = { [weak self] in
            if self?.products[indexPath.row].quantity ?? 0 > 0 {
                self?.products[indexPath.row].quantity -= 1
                self?.collectionView.reloadItems(at: [indexPath])
                self?.updateTotal()
            }
        }
        
        cell.delegate = self
        
        return cell
    }
}

extension ProductCollectionViewController: ProductCellDelegate {
    func didTapDelete(cell: ProductCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            if products[indexPath.row].quantity > 0 {
                products[indexPath.row].quantity = 0
                collectionView.reloadItems(at: [indexPath])
            }
            updateTotal()
        }
    }
}

extension ProductCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 16
        let spacing: CGFloat = 10
        
        let totalSpacing = padding * 2 + spacing
        let width = (collectionView.frame.width - totalSpacing) / 2
        
        return CGSize(width: width, height: 200)
    }
}

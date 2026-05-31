//
//  ProductCell.swift
//  lecture 17
//
//  Created by naat minasiani on 31/05/2026.
//
import UIKit

protocol ProductCellDelegate: AnyObject {
    func didTapDelete(cell: ProductCell)
}

class ProductCell: UICollectionViewCell {
    weak var delegate: ProductCellDelegate?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .systemGreen
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let quantityLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let minusBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGray5
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "trash"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var onAdd: (() -> Void)?
    var onMinus: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        backgroundColor = .white
        
    
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(minusBtn)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(addBtn)
        contentView.addSubview(deleteBtn)
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
      
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
        
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
       
            minusBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            minusBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            minusBtn.widthAnchor.constraint(equalToConstant: 28),
            minusBtn.heightAnchor.constraint(equalToConstant: 28),
            
    
            quantityLabel.centerYAnchor.constraint(equalTo: minusBtn.centerYAnchor),
            quantityLabel.leadingAnchor.constraint(equalTo: minusBtn.trailingAnchor, constant: 8),
            
           
            addBtn.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            addBtn.centerYAnchor.constraint(equalTo: minusBtn.centerYAnchor),
            addBtn.widthAnchor.constraint(equalToConstant: 28),
            addBtn.heightAnchor.constraint(equalToConstant: 28),

            deleteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deleteBtn.centerYAnchor.constraint(equalTo: minusBtn.centerYAnchor),
            deleteBtn.widthAnchor.constraint(equalToConstant: 24),
            deleteBtn.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupActions() {
        addBtn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        minusBtn.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    @objc private func addTapped() {
        onAdd?()
    }
    
    @objc private func minusTapped() {
        onMinus?()
    }
    
    @objc private func deleteTapped() {
        delegate?.didTapDelete(cell: self)
    }
}

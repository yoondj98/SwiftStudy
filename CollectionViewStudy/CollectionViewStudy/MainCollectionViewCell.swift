//
//  MainCollectionViewCell.swift
//  CollectionViewStudy
//
//  Created by 윤동주 on 4/30/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseidentifier = "MainCollectionViewCell"
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    // MARK: - Initializer

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupUI(){
        [imageView].forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    private func setupConstraints() {
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

//
//  MainViewHeader.swift
//  CollectionViewStudy
//
//  Created by 윤동주 on 5/1/24.
//

import UIKit

class MainViewHeader: UICollectionReusableView {
    
    // MARK: - Properties

    static let reuseIdentifier = "MainViewHeader"
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "제목"
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
        self.setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupUI(){
        [titleLabel].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}

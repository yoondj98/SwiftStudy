//
//  SearchTableViewCell.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/27/24.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SearchTableViewCell"
    
    /// 앱 아이콘 Image
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.gray.cgColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// 앱 이름 + 요약 설명
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// 앱 이름
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// 앱 요약 설명
    private let appDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("받기",
                        for: .normal)
        button.setTitleColor(.systemBlue,
                             for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16,
                                              weight: .bold)
        button.backgroundColor = UIColor(white: 0.9,
                                         alpha: 1)
        button.layer.cornerRadius = 16
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let appRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        
        label.lineBreakMode = .byTruncatingTail
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let appDeveloperImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "person.crop.square")?
            .withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let appDeveloperLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        
        label.lineBreakMode = .byTruncatingTail
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// 앱 카테고리
    private let appGenresLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appScreenShotsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    func setupUI() {
        self.contentView.addSubview(appImageView)
        
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(appTitleLabel)
        stackView.addArrangedSubview(appDescriptionLabel)
        
        
        self.contentView.addSubview(getButton)
        
        self.contentView.addSubview(appScreenShotsStackView)
        
    }
    
    private func setupConstraints() {
        self.setupAppImageViewConstraints()
        self.setupStackViewConstraints()
        self.setupGetButtonConstraints()
    }
    
    private func setupAppImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.appImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.appImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.appImageView.widthAnchor.constraint(equalToConstant: 45),
            self.appImageView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.appImageView.trailingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.getButton.leadingAnchor, constant: -16),
            self.stackView.centerYAnchor.constraint(equalTo: self.appImageView.centerYAnchor)
        ])
    }

    private func setupGetButtonConstraints() {
        NSLayoutConstraint.activate([
            self.getButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.getButton.centerYAnchor.constraint(equalTo: self.appImageView.centerYAnchor),
            self.getButton.widthAnchor.constraint(equalToConstant: 70),
            self.getButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with appInfo: AppInfo) {
        guard let imageUrl = URL(string: appInfo.imageUrl) else { return }
        ImageCache.shared.load(url: imageUrl, saveOption: .onlyMemory) { image in
            DispatchQueue.main.async {
                self.appImageView.image = image
            }
        }
        
        appTitleLabel.text = appInfo.title
    }
    
    // MARK: - Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.appImageView.image = nil
        self.appTitleLabel.text = nil
        self.appDeveloperLabel.text = nil
        self.appGenresLabel.text = nil
    }
    
    
}

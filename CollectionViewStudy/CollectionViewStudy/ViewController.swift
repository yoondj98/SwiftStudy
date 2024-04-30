//
//  ViewController.swift
//  CollectionViewStudy
//
//  Created by 윤동주 on 4/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var count = 10
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .orange
        return view
    }()
    
    private lazy var addButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("추가", for: .normal)
        let buttonAction = UIAction { _ in
            self.count += 1
            self.collectionView.performBatchUpdates({
                // 뒤에서 2번째에 Cell이 추가
                self.collectionView.insertItems(at: [IndexPath(item: self.count-2, section: 0)])
            }) { _ in
                // 추가된 후 가장 아래로 Scroll
                self.scrollToBottom()
            }
            self.collectionView.reloadData()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("삭제", for: .normal)
        let buttonAction = UIAction { _ in
            self.count -= 1
            self.collectionView.performBatchUpdates({
                // 맨 앞의 Cell을 삭제
                self.collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])
            }) { _ in
                // 삭제된 후 가장 상단의 Header로 Scroll
                self.scrollToTop()
            }
            self.collectionView.reloadData()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupConstraints()
        self.configureCollectionView()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Setup
    
    private func setupUI(){
        [collectionView, addButton, deleteButton].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        setupCollectionViewConstraints()
        setupAddbuttonConstraints()
        setupDeletebuttonConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupAddbuttonConstraints() {
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            addButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30),
        ])
    }
    
    private func setupDeletebuttonConstraints() {
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 100),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            deleteButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30),
        ])
    }
    
    // MARK: - Functions
    
    private func configureCollectionView() {
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.reuseidentifier)
        
        
        // Header
        collectionView.register(MainViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: MainViewHeader.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func scrollToTop() {
        collectionView.scrollToSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
    }
    
    private func scrollToBottom() {
        let lastSection = max(0, collectionView.numberOfSections - 1)
        let lastItemIndex = max(0, collectionView.numberOfItems(inSection: lastSection) - 1)
        let indexPath = IndexPath(item: lastItemIndex, section: lastSection)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
}


// MARK: - Extensions

extension ViewController: UICollectionViewDelegate {}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int
    ) -> Int {
        self.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseidentifier,
                                                            for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    // Header
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                            withReuseIdentifier: MainViewHeader.reuseIdentifier, for: indexPath) as? MainViewHeader {
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 5
    }
    
    // 옆 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 3
    }
}

//
//  ViewController.swift
//  UIKitImageCachingStudy
//
//  Created by 윤동주 on 4/27/24.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var appInfos: [AppInfo] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "제목을 입력하세요."
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.register(SearchTableViewCell.self,
                           forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    private var noSearchResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색어를 입력해보세요"
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupConstraints()
        self.view.backgroundColor = .white
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        self.setupSearchBar()
        self.setupTableView()
        self.setupNoSearchResultLabel()
    }
    
    private func setupSearchBar() {
        self.view.addSubview(self.searchBar)
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    private func setupNoSearchResultLabel() {
        self.view.addSubview(noSearchResultLabel)
    }
    
    private func setupConstraints() {
        self.setupSearchBarConstraints()
        self.setupTableViewConstraints()
        self.setupNoSearchResultLabelConstraints()
    }
    
    private func setupSearchBarConstraints() {
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupNoSearchResultLabelConstraints() {
        NSLayoutConstraint.activate([
            self.noSearchResultLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noSearchResultLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    // MARK: - Functions

    private func fetchAppInfo(_ text: String) {
        API.searchAppInfo(text) { [weak self] appInfos in
            self?.appInfos = appInfos
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showNoSearchResultLabel(_ show: Bool) {
        self.noSearchResultLabel.isHidden = !show
        self.tableView.isHidden = show
    }
}

// MARK: - TableView Extensions

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier,
                                                 for: indexPath) as! SearchTableViewCell
        
        if indexPath.row < self.appInfos.count {
            cell.configure(with: appInfos[indexPath.row])
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let text = searchBar.text,
           text.isEmpty == false {
            fetchAppInfo(text)
        }
        showNoSearchResultLabel(false)
    }
    
}

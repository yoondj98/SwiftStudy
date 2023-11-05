//
//  ViewController.swift
//  Alamofire_Study
//
//  Created by 윤동주 on 11/5/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private var alamofireButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGray
        button.setTitle("API 요청 버튼", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setLayouts()
        setConstraints()
    }

    private func setLayouts() {
        view.addSubview(alamofireButton)
        alamofireButton.addTarget(self, action: #selector(alamofireButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            alamofireButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            alamofireButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            alamofireButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            alamofireButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        alamofireButton.layer.cornerRadius = 8
    }
    
    @objc private func alamofireButtonTapped() {
        //url String을 받아옴.
        let url = "https://api.codesquad.kr/signup"
        
        AF.request(url, method: .post).responseDecodable(of: User.self) { response in
            switch response.result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
}


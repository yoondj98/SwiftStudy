//
//  ViewController.swift
//  NaverLoginTest
//
//  Created by 윤동주 on 11/5/23.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire


struct NaverLogin: Decodable {
    var resultCode: String
    var response: Response
    var message: String
    
    struct Response: Decodable {
        var email: String
        var id: String
        var name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case resultCode = "resultcode"
        case response
        case message
    }
}

class ViewController: UIViewController {
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // 네이버 로그인 성공시 처리
    var success: ((_ loginData: NaverLogin) -> Void)? = { loginData in
        dump("로그인 성공 후 처리할 작업")
        dump(loginData)
    }
    
    // 네이버 로그인 실패시 처리
    // AFError는 Alamofire에 내장된 enum 타입 구조체
    var failure: ((_ error: AFError) -> Void)? = { error in
        dump("로그인 실패 시 처리할 작업")
    }
    
    private var loginButton: UIButton = {
        
        var config = UIButton.Configuration.filled()
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        config.title = "네이버 로그인"
        config.attributedTitle = AttributedString("네이버 로그인", attributes: container)
        config.baseBackgroundColor = .green
        config.baseForegroundColor = .black
        config.cornerStyle = .dynamic
        
        
        return UIButton(configuration: config)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naverLoginInstance?.delegate = self
        
        setLayouts()
        setConstraints()
        
    }
    
    @objc private func loginButtonTapped() {
        naverLoginInstance?.requestThirdPartyLogin()
    }
    private func setLayouts() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints() {
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func naverLoginPaser() {
        guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !accessToken {
            return
        }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        let requestUrl = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: requestUrl)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseDecodable(of: NaverLogin.self) { [self] response in
            print(response)
            print(response.result)
            
            switch response.result {
            case .success(let loginData):
                print(loginData.resultCode)
                print(loginData.message)
                print(loginData.response)
                
                if let success = self.success {
                    success(loginData)
                }
                
                break
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                
                if let failure = self.failure {
                    failure(error)
                }
                
                break
            }
        }
    }
    
}

extension ViewController : NaverThirdPartyLoginConnectionDelegate{
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인 성공")
        self.naverLoginPaser()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("네이버 토큰 갱신 성공")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러 = \(error.localizedDescription)")
    }
}

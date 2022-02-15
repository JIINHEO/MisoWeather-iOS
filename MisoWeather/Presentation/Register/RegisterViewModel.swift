//
//  RegisterViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//

import Foundation

final class RegisterViewModel {
    
    private var memberData: MemberModel?
    
    var memberInfo: MemberModel? {
        self.memberData
    }
    

    func token(completion: @escaping (Result<String, APIError>) -> Void) {
        let token = TokenUtils()
        guard let accessToken = token.read("kakao", account: "accessToken") else {return}
        let userID = token.read("kakao", account: "userID")
        
        let body: [String: Any] = [
            "socialId": userID!,
            "socialType": "kakao"
        ]
        
        let urlString = URL.token + accessToken
        print(urlString)
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: encodedString) else {return}
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
        
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.post
        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requeset.httpBody = jsonBody
        
        let networkManager = NetworkManager()
        networkManager.postRegister(url: requeset) {(result: Result<String, APIError>) in
            switch result {
            case .success(let serverToken):
                print("serverToken: \(serverToken)")
                token.create("misoWeather", account: "serverToken", value: serverToken)
                completion(.success(""))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getIsExistUser(completion: @escaping (String) -> Void) {
        let networkManager = NetworkManager()
        let token = TokenUtils()
        guard let id = token.read("kakao", account: "userID") else {return}
        let urlString = URL.existence + id + Path.socialType + "kakao"
        if let url =  URL(string: urlString) {
            networkManager.getfetchData(url: url) {(result: Result<StatusModel, APIError>) in
                switch result {
                case .success(let model):
                    completion(model.message)
                    
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
    }
    
}

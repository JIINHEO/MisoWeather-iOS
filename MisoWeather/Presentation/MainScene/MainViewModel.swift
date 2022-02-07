//
//  MainViewModel.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/05.
//
import Foundation

final class MainViewModel {
    
    private var memberData: MemberModel?
    private var forecastData: CurrentTemp?
    private var location: String = ""

    var memberInfo: MemberModel? {
        self.memberData
    }
    
    var forecastInfo: CurrentTemp? {
        self.forecastData
    }
    
    var locationInfo: String {
        self.location
    }
    
    func getMemberData(completion: @escaping () -> Void) {
        
        let networkManager = NetworkManager()
        
        let token = TokenUtils()
        guard let serverToken =  token.read("misoWeather", account: "serverToken") else {return}
        
        guard let url = URL(string: URL.member) else {return}
        var requeset: URLRequest = URLRequest(url: url)
        requeset.httpMethod = URLMethod.get
        requeset.addValue(serverToken, forHTTPHeaderField: "serverToken")
        
        networkManager.getRequsetData(url: requeset) {(result: Result<MemberModel, APIError>) in
            switch result {
            case .success(let model):
                self.memberData = model
                UserDefaults.standard.set(model.data.regionId, forKey: "regionID")
                completion()
                
            case .failure(let error):
                debugPrint("error = \(error)")
                completion()
            }
        }
    }
    
    func getCurrentTempData(completion: @escaping () -> Void) {
    
        let networkManager = NetworkManager()
        guard let regionID = UserDefaults.standard.string(forKey: "regionID") else {return}
        let urlString = URL.realtimeForecast + regionID
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        if let url =  URL(string: encodedString) {
            networkManager.getfetchData(url: url) {(result: Result<CurrentTemp, APIError>) in
                switch result {
                case .success(let model):
                    self.forecastData = model
                    
                    self.location.append(model.data.region.bigScale)
                    if model.data.region.midScale != "선택 안 함" {
                        self.location.append(" " + model.data.region.midScale)
                        if model.data.region.smallScale != "선택 안 함" {
                            self.location.append(" " + model.data.region.smallScale)
                        }
                    }
                    
                    completion()
                    
                case .failure(let error):
                    debugPrint("error = \(error)")
                }
            }
        }
    }
    
//    func register(completion: @escaping (Result<String, APIError>) -> Void) {
//        
//        let token = TokenUtils()
//        guard let accessToken = token.read("kakao", account: "accessToken") else {return}
//        let userID = token.read("kakao", account: "userID")
//        let regionID = UserDefaults.standard.string(forKey: "regionID")
//      
//        let body: [String: Any] = [
//            "defaultRegionId": regionID!,
//            "emoji": recivedNickName.emoji,
//            "nickname": recivedNickName.nickname,
//            "socialId": userID!,
//            "socialType": "kakao"
//        ]
//        
//        let urlString = URL.sinup + accessToken
//        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
//        guard let url = URL(string: encodedString) else {return}
//        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {return}
//        
//        var requeset: URLRequest = URLRequest(url: url)
//        requeset.httpMethod = URLMethod.post
//        requeset.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        requeset.httpBody = jsonBody
//        
//        let networkManager = NetworkManager()
//        networkManager.postRegister(url: requeset) {(result: Result<String, APIError>) in
//            
//            switch result {
//            case .success(let serverToken):
//                print("serverToken: \(serverToken)")
//                token.create("misoWeather", account: "serverToken", value: serverToken)
//                completion(.success(""))
//                
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}

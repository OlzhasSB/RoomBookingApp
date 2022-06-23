//
//  NetworkManager.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let login: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class NetworkManager {

    static var shared = NetworkManager()

    let link = "http://64.227.72.181:8080/rooms"

    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func auth(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "http://64.227.72.181:8080/authenticate") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(login: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidCredentials))
                }
                return
            }
            
            guard let token = loginResponse.token else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidCredentials))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(token))
            }
        }.resume()
    }
    
    func getReservations(path: Int, token: String, completion: @escaping (Result<[Request], NetworkError>) -> Void) {
        guard let url = URL(string: "\(link)/\(path)") else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            guard let reservations = try? JSONDecoder().decode([Request].self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(reservations))
            }
            
        }.resume()
    }
    
    func postReservation(path: Int, token: String, timefrom: String, timeto: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "\(link)/\(path)") else { return }
    
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        let body: [String: AnyHashable] = [
            "timefrom": timefrom,
            "timeto": timeto,
            "contact": "XXX"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.custom(errorMessage: "There is an error")))
                }
            }
            DispatchQueue.main.async {
                completion(.success("Success!"))
            }
        }
        task.resume()
    }
    
    func register(username: String, password: String) {
        guard let url = URL(string: "http://64.227.72.181:8080/register") else {
            print("URL is not correct")
            return
        }
        
        let body = LoginRequestBody(login: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("There is an error")
            }
            
//            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
//                return
//            }
//
//            guard let token = loginResponse.token else {
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(data))
//            }
            
        }.resume()
    }
    
}






//    private lazy var urlComponents: URLComponents = {
//        var components = URLComponents()
//        components.scheme = "http"
//        components.host = "164.92.196.125:8080"
////        components.queryItems = [
////            URLQueryItem(name: "api_key", value: API_KEY)
////        ]
//        return components
//    }()
     
//    let url = URL(string: "http://164.92.196.125:8080/rooms")
    
//    let link = "http://164.92.196.125:8080/rooms"


//func makePOSTRequest(path: Int, timefrom: String, timeto: String) {
//        guard let url = URL(string: "\(link)/\(path)") else { return }
//
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body: [String: AnyHashable] = [
//            "person": "SSSSSSS",
//            "timefrom": timefrom,
//            "timeto": timeto,
//            "contact": "XXX"
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else { return }
//
//            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(response)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }


//func loadRequests(path: String, completion: @escaping ([Request]) -> Void) {
////        var components = urlComponents
////        components.path = "/rooms/304"
//
////        guard let requestUrl = components.url else {
////            return
////        }
//    guard let url = URL(string: "\(link)/\(path)") else { return }
//
//    let task = session.dataTask(with: url) { data, response, error in
//        guard error == nil else {
//            print("Error: error calling GET")
//            return
//        }
//        guard let data = data else {
//            print("Error: Did not receive data")
//            return
//        }
//        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
//            print("Error: HTTP request failed")
//            return
//        }
//        do {
//            let requestsEntity = try JSONDecoder().decode([Request].self, from: data)
//            DispatchQueue.main.async {
//                completion(requestsEntity)
//            }
//        } catch {
//            DispatchQueue.main.async {
//                completion([])
//            }
//        }
//    }
//    task.resume()
//}

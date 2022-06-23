//
//  NetworkManager.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import Foundation

class NetworkManager {

    static var shared = NetworkManager()
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
    let link = "http://64.227.72.181:8080/rooms"
    
    private let session: URLSession
    
    private init() {
        session = URLSession(configuration: .default)
    }

    func loadRequests(path: String, completion: @escaping ([Request]) -> Void) {
//        var components = urlComponents
//        components.path = "/rooms/304"

//        guard let requestUrl = components.url else {
//            return
//        }
        guard let url = URL(string: "\(link)/\(path)") else { return }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                let requestsEntity = try JSONDecoder().decode([Request].self, from: data)
                DispatchQueue.main.async {
                    completion(requestsEntity)
                }
            } catch {
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
        task.resume()
    }
    
    func makePOSTRequest(path: Int, timefrom: String, timeto: String) {
        guard let url = URL(string: "\(link)/\(path)") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "person": "SSSSSSS",
            "timefrom": timefrom,
            "timeto": timeto,
            "contact": "XXX"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func auth() {
        guard let url = URL(string: "http://64.227.72.181:8080/authenticate") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "login": "string",
            "password": "string"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

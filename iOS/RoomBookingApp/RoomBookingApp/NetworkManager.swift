//
//  NetworkManager.swift
//  RoomBookingApp
//
//  Created by Olzhas Seiilkhanov on 22.06.2022.
//

import Foundation

class NetworkManager {
//    private let API_KEY = "e516e695b99f3043f08979ed2241b3db"
    
//http://164.92.196.125:8080/rooms/304

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
    
    let link = "http://164.92.196.125:8080/rooms"
    
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
        let url = URL(string: "\(link)/\(path)")
        
        let task = session.dataTask(with: url!) { data, response, error in
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
//
//    func loadTodayMovies(completion: @escaping ([Movie]) -> Void) {
//        loadMovies(path: "/3/movie/now_playing") { movies in
//            completion(movies)
//        }
//    }
//    func loadSoonMovies(completion: @escaping ([Movie]) -> Void) {
//        loadMovies(path: "/3/movie/upcoming") { movies in
//            completion(movies)
//        }
//    }
//    func loadTrendingMovies(completion: @escaping ([Movie]) -> Void) {
//        loadMovies(path: "/3/trending/movie/week") { movies in
//            completion(movies)
//        }
//    }
//
//    private func loadMovies(path: String, completion: @escaping ([Movie]) -> Void) {
//        var components = urlComponents
//        components.path = path
//
//        guard let requestUrl = components.url else {
//            return
//        }
//
//        let task = session.dataTask(with: requestUrl) { data, response, error in
//            guard error == nil else {
//                print("Error: error calling GET")
//                return
//            }
//            guard let data = data else {
//                print("Error: Did not receive data")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
//                print("Error: HTTP request failed")
//                return
//            }
//
//            do {
//                let moviesEntity = try JSONDecoder().decode(MoviesEntity.self, from: data)
//                DispatchQueue.main.async {
//                    completion(moviesEntity.results)
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion([])
//                }
//            }
//        }
//        task.resume()
//    }
}

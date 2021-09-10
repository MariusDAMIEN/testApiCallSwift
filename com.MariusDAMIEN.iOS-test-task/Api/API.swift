//
//  API.swift
//  com.MariusDAMIEN.iOS-test-task
//
//  Created by MacBook Pro on 09/09/2021.
//

import Foundation

// BASE URL

class Api {
    
    private var dataTask: URLSessionDataTask?

    func getAlbumsUser(completion: @escaping (Result<[Album], Error>) -> Void) {
        let userURL = "https://jsonplaceholder.typicode.com/albums/?userId=1"
        
        guard let url = URL(string: userURL) else {return}

        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    // ERROR RESPONSE
                    if let error = error {
                        completion(.failure(error))
                        print("DataTask error: \(error.localizedDescription)")
                        return
                    }
                    
                    // EMPTY RESPONSE
                    guard let response = response as? HTTPURLResponse else {
                        print("Empty Response")
                        return
                    }
                    
                    // RESPONSE CODE
                    print("Response status code: \(response.statusCode)")
                    
            
                    // EMPTY DATA
                    guard let data = data else {
                        print("Empty Data")
                        return
                    }
                    
                    do {
                        // PARSER
                        let decoder = JSONDecoder()
                        print(data)
                        let jsonData = try decoder.decode([Album].self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(jsonData))
                        }
                    } catch let error {
                        completion(.failure(error))
                    }
                    
                }
                dataTask?.resume()
        }


    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        let userURL = "https://jsonplaceholder.typicode.com/users/1"
        
        guard let url = URL(string: userURL) else {return}

        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    // ERROR RESPONSE
                    if let error = error {
                        completion(.failure(error))
                        print("DataTask error: \(error.localizedDescription)")
                        return
                    }
                    
                    // EMPTY RESPONSE
                    guard let response = response as? HTTPURLResponse else {
                        print("Empty Response")
                        return
                    }
                    
                    // RESPONSE CODE
                    print("Response status code: \(response.statusCode)")
                    
            
                    // EMPTY DATA
                    guard let data = data else {
                        print("Empty Data")
                        return
                    }
                    
                    do {
                        // PARSER
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(User.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(jsonData))
                        }
                    } catch let error {
                        completion(.failure(error))
                    }
                    
                }
                dataTask?.resume()
    }
    
    func getPhotosData(id: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let userURL = "https://jsonplaceholder.typicode.com/photos/?albumId=" + id
        
        guard let url = URL(string: userURL) else {return}

        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    // ERROR RESPONSE
                    if let error = error {
                        completion(.failure(error))
                        print("DataTask error: \(error.localizedDescription)")
                        return
                    }
                    
                    // EMPTY RESPONSE
                    guard let response = response as? HTTPURLResponse else {
                        print("Empty Response")
                        return
                    }
                    
                    // RESPONSE CODE
                    print("Response status code: \(response.statusCode)")
                    
            
                    // EMPTY DATA
                    guard let data = data else {
                        print("Empty Data")
                        return
                    }
                    
                    do {
                        // PARSER
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode([Photo].self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(jsonData))
                        }
                    } catch let error {
                        completion(.failure(error))
                    }
                    
                }
                dataTask?.resume()
    }
}


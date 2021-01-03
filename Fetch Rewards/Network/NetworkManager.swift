//
//  NetworkManager.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 12/30/20.
//  Copyright © 2020 Edvin Lellhame. All rights reserved.
//

import Foundation

enum FRError: String, Error {
    case invalidURL = "Network: This is an invalid URL."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid respnose from the server. Please try agian."
    case invalidData = "The data received from the server is invalid. Please try agian."
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init () { }
    
    
    func getEvents(completed: @escaping (Result<[Event], FRError>) -> Void) {
        let postsURL = "https://api.seatgeek.com/2/events?client_id=NzU4MDk0M3wxNjA4MjQ5MDY0LjU2Mjg0NDM&geoip=95382&range=60mi"
        
        guard let url = URL(string: postsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(jsonData)
            } catch {
                print("catch error")
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let events = try decoder.decode([Event].self, from: data)
                
                completed(.success(events))
            } catch {
                completed(.failure(.invalidResponse))
            }
        }
        
        task.resume()
    }
}

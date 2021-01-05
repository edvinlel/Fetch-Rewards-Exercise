//
//  JSONDecoder+Extension.swift
//  Fetch Rewards
//
//  Created by Edvin Lellhame on 1/4/21.
//  Copyright © 2021 Edvin Lellhame. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL passed.")
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let downloadedData = try decoder.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

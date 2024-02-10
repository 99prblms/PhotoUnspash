//
//  DataFetcher.swift
//  PhotoUnspash
//
//  Created by Владислав Наумов on 10.02.2024.
//

import Foundation

class DataFetcher {
    
    var apiManager = ApiManager()
    
    func fetchImages(searchWord: String, completion: @escaping (SearchResults?) -> ()) {
        apiManager.request(searchWord: searchWord) { data, error in
            if let error = error {
                print("Error received reauesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
}

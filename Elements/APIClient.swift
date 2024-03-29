//
//  APIClient.swift
//  Elements
//
//  Created by hildy abreu on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class APIClient {
    private init() {}
    
    static let shared = APIClient()
    
    func getElement(completionHandler: @escaping (Result<[ElementWrapper], AppError>) -> Void) {
        let urlStr = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let elementWrapper = try JSONDecoder().decode([ElementWrapper].self, from: data)
                    completionHandler(.success(elementWrapper))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
}
    
    
    
    func postElement(favorite: FavoriteElement, completionHandler: @escaping(Result<Data, AppError>)-> Void){
        let urlStr = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        guard let url = URL(string: urlStr) else {
                   completionHandler(.failure(.badURL))
                   return
               }
               
        guard let encodedData = try? JSONEncoder().encode(favorite) else {
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andHTTPBody: encodedData, andMethod: .post) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                completionHandler( .success(data))
            }
        }
    }

}

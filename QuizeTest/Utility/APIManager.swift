//
//  APIManager.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

import Foundation

enum DataError:Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case decodingError(_ error: Error?)
}


final class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    func fetchQuestions(completionHandler : @escaping (Result<[Query], DataError>) -> Void) {
        
        guard let url = URL(string: Constant.API.queryURL) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        //print("RequestURL:-", url)
        
        URLSession.shared.dataTask(with: url) {(responseData, responseURL, responseError) in
            guard let responseData, responseError == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            //print("ResponseData:-", responseData)
            
            guard let respose = responseURL as? HTTPURLResponse, 200 ... 299 ~= respose.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            //print("ResponseStatusCode:-", respose.statusCode)
            //let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            //print("ResponseJsonData:-", jsonData!)
            
            do {
                let banners = try JSONDecoder().decode([Query].self, from: responseData)
                completionHandler(.success(banners))
            }catch let error {
                //print("DecodingError:-",error)
                completionHandler(.failure(.decodingError(error)))
            }
            
        }.resume()
        
    }
}

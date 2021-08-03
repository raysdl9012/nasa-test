//
//  ManagerRequest.swift
//  Movies
//
//  Created by Reinner Daza Leiva on 14/06/21.
//

import Foundation


typealias COMPLETION_HTTP = (_ data: Data?, _ error: Error? ) -> Void
typealias COMPLETION_DATA = (_ data: Any?, _ error: Error? ) -> Void

enum ENPOINTS: String {
    case BASE_URL = "https://images-api.nasa.gov/"
    case SEARCH = "search"
}

enum ErrorsRequest: Error {
    case BAD_REQUEST
    case BAD_URL
}

enum METHOD_HTTP: String {
    case GET = "GET"
    case POST = "POST"
}

class ManagerRequest {
    
    static let instance = ManagerRequest()
    
    private var sessionRequest: URLSession = URLSession.shared
    
    init() {
        
    }
    
    public func makeRequest(
        method: METHOD_HTTP,
        baseUrl: ENPOINTS,
        endpoint: ENPOINTS,
        params: String,
        body: Dictionary<String,Any>?, completion: @escaping COMPLETION_HTTP){
        
        guard let url =  URL(string: baseUrl.rawValue + endpoint.rawValue + params) else {
            completion(nil, ErrorsRequest.BAD_URL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        self.sessionRequest.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            if (response.statusCode == 400) {
                completion(nil, ErrorsRequest.BAD_REQUEST)
            }
            
            if (response.statusCode == 200) {
                completion(data, nil)
            }
        }.resume()
    }
    
    public func downloadImage(from imagePath: String, completion: @escaping COMPLETION_DATA) {
        
        let finalImage = imagePath.replacingOccurrences(of: " ", with: "%")
        guard let url =  URL(string: finalImage) else {
            completion(nil, ErrorsRequest.BAD_URL)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            
            if (response.statusCode == 404) {
                completion(nil, error)
                return
            }
            
            if (response.statusCode == 400) {
                completion(nil, error)
                return
            }
            
            if (response.statusCode == 200) {
                completion(data, nil)
                return
            }
            
        }).resume()
    }
    
}

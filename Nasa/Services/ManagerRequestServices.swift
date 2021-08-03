//
//  ManagerRequestServices.swift
//  Movies
//
//  Created by Reinner Daza Leiva on 14/06/21.
//

import Foundation
import UIKit


class ManagerRequestServices {
    
    static let instance = ManagerRequestServices()
    
    func getSearch(searchText:String, completion: @escaping COMPLETION_DATA)  {
        ManagerRequest.instance.makeRequest(method: .GET,
                                            baseUrl: .BASE_URL,
                                            endpoint: .SEARCH,
                                            params: "?q=\(searchText)",
                                            body: nil) { data, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let items = self.convertNasaItems(data: data!) else {
                return
            }
            
            completion(items,error)
        }
    }
    
    
    func dowloadImage(path: String, completion: @escaping COMPLETION_DATA) {
        
        ManagerRequest.instance.downloadImage(from: path) { (data, error) in
            guard error == nil, data != nil else {
                completion(nil, error)
                return
            }
            let image = self.convertDataToImage(data: data as! Data)
            completion(image,nil)
        }
    }

        
    private func convertDataToImage(data:Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    private func convertNasaItems(data:Data) -> NasaResponse? {
        var items:NasaResponse?
        do {
            items = try JSONDecoder().decode(NasaResponse.self, from: data)
        } catch  {
            print("Error \(error)")
        }
        return items
    }
}

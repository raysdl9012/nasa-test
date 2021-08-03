//
//  HomeInteractor.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import Foundation


protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? {get set}
    func getSearch(text:String)
}


class HomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomePresenterProtocol?
    
    func getSearch(text: String) {
        ManagerRequestServices.instance.getSearch(searchText: text) { response, error in
            
            guard error == nil else{
                return
            }
            
            if let responseData = response as? NasaResponse {
                self.presenter?.presentNasaItems(items: responseData)
            }
        }
    }
    
     
    
}

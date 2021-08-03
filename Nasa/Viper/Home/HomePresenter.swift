//
//  HomePresenter.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import Foundation




protocol HomePresenterProtocol {
    
    var view: HomeViewProtocol? { get set }
    var presenter: HomePresenterProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    
    
    func interactorGetSearch(text:String)
    func presentNasaItems(items: NasaResponse)

}

class HomePresenter: HomePresenterProtocol {

    
   
    var view: HomeViewProtocol?
    var presenter: HomePresenterProtocol?
    var interactor: HomeInteractorProtocol?
    
    func interactorGetSearch(text: String) {
        self.interactor?.getSearch(text: text)
    }
    
    func presentNasaItems(items: NasaResponse) {
        DispatchQueue.main.async {
            self.view?.updateNasaItems(items: items)
        }
        
    }
}

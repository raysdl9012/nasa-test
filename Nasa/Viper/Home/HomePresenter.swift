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
    
    
    var listItems: [NasaItems]? { get set }
    var response: NasaResponse? { get set }

    func filterItemsNasa(text:String)
    func interactorGetSearch(text:String)
    func updateItemNasa(item:NasaItems)
    func presenterDetail(item:NasaItems)
    func presentNasaItems(items: NasaResponse)
    
}

class HomePresenter: HomePresenterProtocol {
    
    var listItems: [NasaItems]?
    var response: NasaResponse?
    
    var view: HomeViewProtocol?
    var presenter: HomePresenterProtocol?
    var interactor: HomeInteractorProtocol?
    
    
    
    func interactorGetSearch(text: String) {
        self.interactor?.getSearch(text: text)
    }
    
    func presentNasaItems(items: NasaResponse) {
        self.response = items
        self.listItems = self.response?.collection.items
        self.updateView()
    }
    
    func filterItemsNasa(text: String) {
        
        if text == "" {
            self.listItems = self.response?.collection.items
            self.updateView()
            return
        }
        
        let itemsNasa =  self.getFilterResults(text: text)
        
        if itemsNasa != nil {
            self.listItems = itemsNasa
            self.updateView()
        }
    }
    
    func presenterDetail(item:NasaItems) {
        let vc = RouterFacade.instance.getDetailView(item:item)
        DispatchQueue.main.async {
            RouterFacade.instance.pushNavigationController(view: vc)
        }
    }
    
    func updateItemNasa(item: NasaItems) {
        if let index = self.listItems?.firstIndex(where: { obj in
            return obj.href == item.href
        }) {
            
            
            self.listItems![index] = item
            self.updateView()
        }
        
        
    }
    
    private func getFilterResults(text: String) -> [NasaItems]? {
        let itemsNasa =  self.response?.collection.items.filter({ item in
            let keys =  item.data![0].keywords?.filter({ key in
                                                            
                                                            //print("Key: \(key.lowercased()) Text: \(text.lowercased()) result: \(key.lowercased().contains(text.lowercased()))")
                                                            return key.lowercased().contains(text.lowercased())  })
            return keys == nil ? false :  keys!.count > 0
        })
        return itemsNasa
    }
    
    private func updateView(){
        DispatchQueue.main.async {
            self.view?.updateNasaItems(items: self.listItems!)
        }
    }
}

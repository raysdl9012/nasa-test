//
//  HomePresenter.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import Foundation




protocol DetailPresenterProtocol {
    var itemNasa: NasaItems? { get set }
    var view: DetailViewProtocol? { get set }
    var presenter: DetailPresenterProtocol? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    var itemNasa: NasaItems?
    var view: DetailViewProtocol?
    var presenter: DetailPresenterProtocol?
    
    init() {
        
    }
    
    init(itemNasa: NasaItems) {
        self.itemNasa = itemNasa
    }
}

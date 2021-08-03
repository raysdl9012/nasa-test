//
//  HomeRouter.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import UIKit


typealias EntryPointDetail = DetailViewProtocol & UIViewController

protocol DetailRouterProtocol {
    var entry: EntryPointDetail? {get}
    static func start(item:NasaItems) -> DetailRouterProtocol
}

class DetailRouter:DetailRouterProtocol  {
    
    var entry: EntryPointDetail?
    static func start(item:NasaItems) -> DetailRouterProtocol {
        let router = DetailRouter()
        var view: DetailViewProtocol =  DetailViewController.loadFromNib()
        var presenter: DetailPresenterProtocol = DetailPresenter(itemNasa: item)
        view.presenter = presenter
        presenter.view = view
        router.entry = view as? EntryPointDetail
        return router
    }
    
}

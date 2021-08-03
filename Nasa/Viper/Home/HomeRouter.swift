//
//  HomeRouter.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import UIKit




typealias EntryPointHome = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var entry: EntryPointHome? {get}
    static func start() -> HomeRouterProtocol
}

class HomeRouter:HomeRouterProtocol  {
    var entry: EntryPointHome?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        var view: HomeViewProtocol =  HomeViewController.loadFromNib()
        var presenter: HomePresenterProtocol = HomePresenter()
        var interactor: HomeInteractorProtocol = HomeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.presenter = presenter
        interactor.presenter =  presenter
        
        router.entry = view as? EntryPointHome
        return router
    }
    
    
}

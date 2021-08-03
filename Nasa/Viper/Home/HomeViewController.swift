//
//  HomeViewController.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import UIKit

protocol HomeViewProtocol {
    var listItems: [NasaItems]? {get set}
    var presenter: HomePresenterProtocol? {get set}
    func updateNasaItems(items: [NasaItems])
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifire = "HomeTableViewCell"
    public var searchText = ""
    public var presenter: HomePresenterProtocol?
    public var listItems: [NasaItems]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableView()
        self.createSearchController()
        self.title = "Apollo"
        self.presenter?.interactorGetSearch(text: "apollo%2011")
    }
    
    private func loadTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.loadCustomCell(cellIndentifire: self.cellIdentifire)
    }
    
    private func createSearchController(){
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
    }
    
    func updateNasaItems(items: [NasaItems]) {
        self.listItems = items
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.listItems![indexPath.row]
        self.presenter?.presenterDetail(item:item)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifire, for: indexPath) as! HomeTableViewCell
        let item = self.listItems![indexPath.row]
        cell.loadCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if text == "" {
            return
        }
        self.searchText = text
        print(self.searchText)
        self.presenter?.filterItemsNasa(text: self.searchText)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        self.presenter?.filterItemsNasa(text: "")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing")
        self.presenter?.filterItemsNasa(text: self.searchText)
        return true
    }
    
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        print("end")
//        guard let text = searchBar.text else {
//            return true
//        }
//        self.presenter?.filterItemsNasa(text: text)
//        return true
//    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
        print(self.searchText)
        self.presenter?.filterItemsNasa(text: self.searchText)
    }
    
}

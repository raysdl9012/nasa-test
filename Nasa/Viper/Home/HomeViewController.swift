//
//  HomeViewController.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import UIKit





protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? {get set}
    func updateNasaItems(items: NasaResponse)

}

class HomeViewController: UIViewController, HomeViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    
    private let cellIdentifire = "HomeTableViewCell"
    public var presenter: HomePresenterProtocol?
    public var listItems: NasaResponse? {
        didSet {
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableView()
        self.title = "Apollo"
        self.presenter?.interactorGetSearch(text: "apollo%2011")
    }
    
    func updateNasaItems(items: NasaResponse) {
        self.listItems = items
    }
    
    private func loadTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.loadCustomCell(cellIndentifire: self.cellIdentifire)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.listItems != nil) ? self.listItems!.collection.items.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifire, for: indexPath) as! HomeTableViewCell
        cell.loadCell(item: self.listItems!.collection.items[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//
//  DetailViewController.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 3/08/21.
//

import UIKit



protocol DetailViewProtocol {
    var itemNasa: NasaItems? { get set }
    var presenter: DetailPresenterProtocol? { get set }
}

class DetailViewController: UIViewController, DetailViewProtocol {
    
    
    
    var itemNasa: NasaItems?
    var presenter: DetailPresenterProtocol?
    
    
    private let cellIdentifire = "DetailTableViewCell"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableView()
        self.loadInfo()
    }
    
    private func loadInfo(){
        self.itemNasa = self.presenter?.itemNasa
    }
    
    private func loadTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.loadCustomCell(cellIndentifire: self.cellIdentifire)
    }
}


extension DetailViewController: UITableViewDelegate {
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifire, for: indexPath) as! DetailTableViewCell
        cell.delegate = self
        cell.loadCell(item: self.itemNasa!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension DetailViewController: CellDetailProtocol {
    func updateItem(item: NasaItems) {
        print(item)
        NotificationCenter.default.post(name: .updateItemNasa, object: item)
    }
}

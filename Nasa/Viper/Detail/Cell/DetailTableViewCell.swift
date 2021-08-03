//
//  DetailTableViewCell.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 3/08/21.
//

import UIKit

protocol CellDetailProtocol {
    func updateItem(item: NasaItems)
}

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNasa: UILabel!
    @IBOutlet weak var imageNasa: UIImageView!
    @IBOutlet weak var descriptionNasa: UILabel!
    @IBOutlet weak var createNasa: UILabel!
    @IBOutlet weak var imageLike: UIImageView!
    
    private var item: NasaItems?
    public var delegate: CellDetailProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(item:NasaItems) {
        self.item = item
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tabLikeButton(_:)) )
        self.imageLike.addGestureRecognizer(tapGestureRecognizer)
        self.titleNasa.text =  item.data![0].title
        self.descriptionNasa.text =  item.data![0].description
        self.createNasa.text =  item.data![0].date_created
        if let image = ManagerCache.instance.getImageFromCache(forKey: item.data![0].nasa_id) {
            self.imageNasa?.image = image
        }
        
        if ((self.item?.like) != nil) {
            if self.item!.like! {
                self.imageLike.tintColor =  UIColor.orange
            }else{
                self.imageLike.tintColor =  UIColor.lightGray
            }
        }
        
        
    }
    
    @objc func tabLikeButton(_ sender: UITapGestureRecognizer) {
      
        if (self.item?.like == nil) {
            self.item?.like =  true
        }else{
            if self.item!.like! {
                self.item?.like = false
            }else{
                self.item?.like = true
            }
        }
        
        if self.item!.like! {
            self.imageLike.tintColor =  UIColor.orange
        }else{
            self.imageLike.tintColor =  UIColor.lightGray
        }
        self.delegate?.updateItem(item: self.item!)
    }
}

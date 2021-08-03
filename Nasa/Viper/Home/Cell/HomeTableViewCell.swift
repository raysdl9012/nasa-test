//
//  HomeTableViewCell.swift
//  Nasa
//
//  Created by Reinner Daza Leiva on 2/08/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var imageStart: UIImageView!
    
    var itemNasa: NasaItems!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadCell(item:NasaItems) {
        self.cleanCell()
        self.itemNasa = item
        self.titleItem.text = item.data![0].title
        self.imageItem?.backgroundColor = .darkGray
        self.imageItem?.configImage()
        self.loadAccesoriType()
        if let link = self.getLinkImage() {
            self.searchImageInCache(id: item.data![0].nasa_id, path: link[0].href)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tabLikeButton(_:)) )
        self.imageStart.addGestureRecognizer(tapGestureRecognizer)
        self.imageStart.isUserInteractionEnabled = true
        
    }
    
    private func cleanCell(){
        self.titleItem.text = ""
        self.imageItem?.image = nil
        self.accessoryType = .none
        self.imageStart.isHidden = true
    }
    
    private func getLinkImage() -> [LinksImage]? {
        let link =  self.itemNasa.links?.filter({ item in
            return item.rel == "preview"
        })
        return link
    }
    
    private func searchImageInCache(id:String, path: String){
        if let image = ManagerCache.instance.getImageFromCache(forKey: id) {
            self.imageItem?.image = image
        }else{
            self.downloadImage(id:id, path: path)
        }
    }
    
    private func downloadImage(id:String, path: String){
        
        ManagerRequestServices.instance.dowloadImage( path: path ){ [weak self]  (imageResponse, error) in
            guard error == nil else{
                // print("** Error \(error!)")
                DispatchQueue.main.async {
                    self?.imageItem?.backgroundColor = UIColor(red: 102/255, green: 153/255, blue: 102/255, alpha: 1)
                    self!.imageItem?.image = UIImage(named: "errorImage")
                }
                return
            }
            
            if let image = imageResponse as? UIImage {
                DispatchQueue.main.async {
                    ManagerCache.instance.saveImageInCache(image: image, forKey: id)
                    self!.imageItem?.image = image
                }
            }
        }
    }
    
    
    private func loadAccesoriType(){
        if self.itemNasa.like != nil {
            if self.itemNasa.like! {
                self.imageStart.isHidden = false
            }else{
                self.accessoryType = .disclosureIndicator
                self.imageStart.isHidden = true
            }
        }else{
            self.accessoryType = .disclosureIndicator
            self.imageStart.isHidden = true
        }
    }
    
    @objc func tabLikeButton(_ sender: UITapGestureRecognizer) {
        if self.itemNasa!.like! {
            self.itemNasa?.like = false
            self.loadAccesoriType()
        }
    }
    
    
}



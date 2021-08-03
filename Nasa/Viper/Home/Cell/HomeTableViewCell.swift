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
        self.imageItem?.configImage()
        if let link = self.getLinkImage() {
            self.searchImageInCache(id: item.data![0].nasa_id, path: link[0].href)
        }
    }
    
    private func cleanCell(){
        self.titleItem.text = ""
        self.imageItem?.image = nil
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
                print("Error \(error!)")
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
}

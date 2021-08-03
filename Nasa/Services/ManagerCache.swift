//
//  ManagerCache.swift
//  CS_iOS_Assignment
//
//  Created by Reinner Daza Leiva on 24/03/21.
//  Copyright © 2021 Backbase. All rights reserved.
//

import UIKit

class ManagerCache {
    
    static let instance = ManagerCache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func cleanCache()  {
        self.cache.removeAllObjects()
    }

    func getImageFromCache(forKey key: String) -> UIImage? {
        return self.cache.object(forKey: key as NSString)
    }

    func saveImageInCache(image: UIImage, forKey key: String) {
        self.cache.setObject(image, forKey: key as NSString)
    }
}

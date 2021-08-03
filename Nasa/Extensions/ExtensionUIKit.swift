//
//  Extensions.swift
//  Movies
//
//  Created by Reinner Daza Leiva on 15/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}

extension UITableView {
    func loadCustomCell(cellIndentifire: String) {
        let nib = UINib(nibName: cellIndentifire, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellIndentifire)
    }
}

extension UIImageView {
    func configImage() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
    }
}

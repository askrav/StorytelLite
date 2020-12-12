//
//  UITableView+Ext.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T
    }
    
    func register<T: UITableViewCell>(cell: T.Type, bundle: Bundle? = nil) {
        self.register(cell, forCellReuseIdentifier: String(describing: T.self))
    }
}

//
//  UIViewController+Ext.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import UIKit

extension UIViewController {
    func showError(message: String? = nil) {
        let alert = UIAlertController(title: Localizable.errorTitle().capitalized,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localizable.ok().capitalized, style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

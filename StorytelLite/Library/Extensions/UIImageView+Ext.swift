//
//  UIImageView+Ext.swift
//  StorytelLite
//
//  Created by Alex Kravchenko on 11.12.2020.
//

import Kingfisher

extension UIImageView {
    func loadImage(url: URL, placeholder: UIImage? = nil) {
        kf.setImage(with: url, placeholder: placeholder)
    }
}

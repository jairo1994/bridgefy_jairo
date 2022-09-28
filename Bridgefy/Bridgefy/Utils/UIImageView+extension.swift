//
//  File.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 28/09/22.
//

import UIKit

extension UIImageView {
    func setImageTintColor(_ color: UIColor) {
        let tintedImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tintedImage
        self.tintColor = color
    }
}

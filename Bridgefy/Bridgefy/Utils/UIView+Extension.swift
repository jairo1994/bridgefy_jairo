//
//  UIView+Constrains.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 28/09/22.
//

import UIKit

extension UIView {
    func constraintToParent(parent: UIView, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: leading),
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: trailing),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: bottom)
        ])
    }
    
    func shadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 1
    }
}

//
//  UIViewController+extension.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 28/09/22.
//

import UIKit

extension UIView {
    func getStack(axis: NSLayoutConstraint.Axis = .vertical, aligment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fill, space: CGFloat = 16) -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = aligment
        stackView.distribution = distribution
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    func getView(corner: CGFloat = 0) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = corner
        
        return view
    }
    
    func getLabel(text: String, size: CGFloat = 19, font: UIFont.Weight = .regular) -> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: size, weight: font)
        
        return lbl
    }
    
    func getImage(content: UIView.ContentMode = .scaleToFill) -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = content
        
        return image
    }
}

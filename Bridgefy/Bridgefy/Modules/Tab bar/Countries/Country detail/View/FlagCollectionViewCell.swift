//
//  FlagCollectionViewCell.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 28/09/22.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(border: String){
        let img = getLabel(text: flag(country: border), size: 45)
        let stack = getStack(axis: .horizontal, aligment: .fill, distribution: .fill, space: 8)
        
        stack.addArrangedSubview(img)
        contentView.addSubview(stack)
        stack.constraintToParent(parent: contentView)
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        
        return String(s)
    }
    
}

//
//  CountryTableViewCell.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import UIKit
import Kingfisher

class CountryTableViewCell: UITableViewCell {
    private let countryImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let nameLbl: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
       
        return label
    }()
    
    private let alphaLbl: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let stackText: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        
        return stack
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellBy(_ country: CountryModel){
        nameLbl.text = country.name
        alphaLbl.text = "\(country.alpha2Code) / \(country.alpha3Code)"
        
        if let url = URL(string: country.flags.png) {
            countryImage.kf.setImage(with: url)
        }
        
        setupView()
    }
    
    func setupView(){
        countryImage.removeFromSuperview()
        stackText.removeFromSuperview()
        
        contentView.addSubview(countryImage)
        stackText.addArrangedSubview(alphaLbl)
        stackText.addArrangedSubview(nameLbl)
        contentView.addSubview(stackText)
        
        NSLayoutConstraint.activate([
            countryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            countryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryImage.widthAnchor.constraint(equalToConstant: 60),
            
            stackText.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor, constant: 12),
            stackText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}

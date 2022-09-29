//
//  LocationModel.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import Foundation

struct CountryModel: Decodable {
    var name: String
    var alpha2Code: String
    var alpha3Code: String
    var region: String
    var flags: FlagsModel
}

struct FlagsModel: Decodable {
    var png: String
    
    init() {
        png = ""
    }
}

struct CountriesByRegion {
    var region: String
    var countries: [CountryModel]
}

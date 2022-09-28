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
}

struct CountriesByRegion {
    var region: String
    var countries: [CountryModel]
}


struct CountryDetailModel: Decodable {
    var name: String
    var alpha2Code: String
    var alpha3Code: String
    var region: String
    var flags: FlagsModel
    var capital: String?
    var nativeName: String
    var borders: [String]?
    var population: Int
    var currencies: [Currencies]
    var callingCodes: [String]
    var languages: [LanguagesModel]
    var timezones: [String]
    var subregion: String
    var area: Int
    var latlng: [Double]
}

struct LanguagesModel: Decodable {
    var name: String
}

struct Currencies: Decodable {
    var code: String
}

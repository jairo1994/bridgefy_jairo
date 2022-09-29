//
//  CountryDetailModel.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 29/09/22.
//

import Foundation

struct CountryDetailModel: Decodable {
    var name: String
    var alpha2Code: String
    var alpha3Code: String
    var region: String
    var capital: String?
    var nativeName: String
    var borders: [String]?
    var population: Int
    var callingCodes: [String]
    var timezones: [String]?
    var subregion: String
    var area: Int
    var latlng: [Double]
    var flags: FlagsModel
    var currencies: [Currencies]
    var languages: [LanguagesModel]
    
    
    init(){
        self.name = ""
        self.alpha2Code = ""
        self.alpha3Code = ""
        self.region = ""
        self.capital = ""
        self.nativeName = ""
        self.borders = [""]
        self.population = 0
        self.callingCodes = [""]
        self.timezones = [""]
        self.subregion = ""
        self.area = 0
        self.latlng = [0.0]
        self.flags = FlagsModel()
        self.currencies = [Currencies]()
        self.languages = [LanguagesModel]()
    }
    
}

struct LanguagesModel: Decodable {
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    init() {
        name = ""
    }
}

struct Currencies: Decodable {
    var code: String
    
    init(code: String){
        self.code = code
    }
    
    init() {
        code = ""
    }
}

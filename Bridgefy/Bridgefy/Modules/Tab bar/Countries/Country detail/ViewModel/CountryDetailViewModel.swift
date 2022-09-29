//
//  CountryDetailModel.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 29/09/22.
//

import Foundation

class CountryDetailViewModel {
    var didFetchLocation: ((Bool) -> Void)?
    var countryDetail = CountryDetailModel()
    var isSaved: Bool
    
    init(countryDetail: CountryDetailModel, isSaved: Bool) {
        self.countryDetail = countryDetail
        self.isSaved = isSaved
    }
    
    func save() {
        DataManager.shared.save(country: self.countryDetail)
        isSaved = true
    }
    
    func delete() {
        DataManager.shared.delete(name: self.countryDetail.name)
        isSaved = false
    }
}

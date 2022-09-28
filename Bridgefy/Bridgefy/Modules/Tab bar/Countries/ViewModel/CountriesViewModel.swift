//
//  CountriesViewModel.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import Foundation

class CountriesViewModel {
    var didFetchLocation: ((Bool) -> Void)?
    var countries = [CountryModel]()
    
    func lookForCountries() {
        didFetchLocation?(false)
        RestCountriesService().allCountries { locationsSearched in
            if let locationsSearched = locationsSearched {
                self.countries = locationsSearched
                self.didFetchLocation?(true)
            }else{
                self.didFetchLocation?(false)
                self.countries = [CountryModel]()
            }
        }
    }
    
    func numberOfRows()-> Int {
        return countries.count
    }
    
    func getCountryByIndex(index: Int)-> CountryModel?{
        if countries.indices.contains(index){
            return countries[index]
        }else{
            return nil
        }
    }
}

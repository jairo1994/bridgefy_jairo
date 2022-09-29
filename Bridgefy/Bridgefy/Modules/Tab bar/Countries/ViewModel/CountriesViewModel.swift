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
    var countriesSaved = [CountryModel]()
    
    var countriesByRegion = [CountriesByRegion]()
    
    var isFiltered: Bool = false
    var isGrouped: Bool = false
    
    func lookForCountries() {
        didFetchLocation?(false)
        RestCountriesService().allCountries { locationsSearched in
            if let locationsSearched = locationsSearched {
                self.countries = locationsSearched
                self.countriesSaved = locationsSearched
                self.sortCountriesByRegion()
                self.didFetchLocation?(true)
            }else{
                self.didFetchLocation?(false)
                self.countries = [CountryModel]()
                self.countriesSaved = [CountryModel]()
            }
        }
    }
    
    func sortCountriesByRegion() {
        countries.forEach { country in
            if let index = countriesByRegion.firstIndex(where: { $0.region == country.region }) {
                countriesByRegion[index].countries.append(country)
            } else {
                countriesByRegion.append(CountriesByRegion(region: country.region, countries: [country]))
            }
        }
    }
    
    func numberOfRows(section: Int? = nil) -> Int {
        if isGrouped {
            if let section = section {
                return countriesByRegion[section].countries.count
            }
            return 0
        } else {
            return countries.count
        }
    }
    
    func numberOfSections() -> Int {
        return countriesByRegion.count
    }
    
    func getCountryByIndex(index: IndexPath)-> CountryModel?{
        if isGrouped, countriesByRegion.indices.contains(index.section), countriesByRegion[index.section].countries.indices.contains(index.item){
            return countriesByRegion[index.section].countries[index.item]
        }else if countries.indices.contains(index.item){
            return countries[index.item]
        }else{
            return nil
        }
    }
    
    func getRegionName(section: Int) -> String{
        if countriesByRegion.indices.contains(section) {
            return countriesByRegion[section].region
        }
        
        return ""
    }
    
    func isLookingFor(_ filter: Bool, text: String = "") {
        self.isFiltered = filter
        
        if filter {
            self.countries = self.countries.filter { $0.name.contains(text) || $0.alpha2Code.contains(text) || $0.alpha3Code.contains(text) }
        } else {
            self.countries = self.countriesSaved
        }
    }

    func lookForCountryDetail(indexPath: IndexPath, completion: @escaping(_ country: CountryDetailModel?, _ isSaved: Bool)->Void){
        didFetchLocation?(false)
        guard let country = self.getCountryByIndex(index: indexPath) else {
            completion(nil, false)
            didFetchLocation?(true)
            return
        }
        
        if let country = DataManager.shared.retrieveCountryBy(country.name) {
            completion(country, true)
            self.didFetchLocation?(true)
        } else {
            RestCountriesService().countryDetail(country: country.name) { country in
                completion(country, false)
                self.didFetchLocation?(true)
            }
        }
        
    }
}

//
//  RestCountriesService.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import Foundation
import Alamofire

class RestCountriesService{
    
    private var baseUrl = "https://restcountries.com/v2/"
    var allCountries = "all"
    var detailCountry = "name/$country"
    
    let header: HTTPHeaders = HTTPHeaders()
    
    static var shared: RestCountriesService{
        let apiService = RestCountriesService()
        return apiService
    }
    
    func allCountries(Callback: @escaping(_ locations: [CountryModel]?)->Void){
        let url = "\(baseUrl)\(allCountries)"
        
        RequestService.shared.getFrom(url: url, timeOutInterval: 20, headers: header, type: [CountryModel].self) { (data, error) in
            if error == nil, let objc = data as? [CountryModel]{
                Callback(objc)
            }else{
                Callback(nil)
            }
        }
    }
    
    func countryDetail(country: String, Callback: @escaping(_ country: CountryDetailModel?)->Void){
        let url = "\(baseUrl)\(detailCountry.replacingOccurrences(of: "$country", with: country))"

        RequestService.shared.getFrom(url: url, parameters: nil, timeOutInterval: 20, headers: header, type: [CountryDetailModel].self) { (data, error) in
            if error == nil, let objc = data as? [CountryDetailModel]{
                Callback(objc.first)
            }else{
                Callback(nil)
            }
        }
    }
    
    
}

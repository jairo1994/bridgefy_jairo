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
    
//    func lookForRequest(lookFor: String, Callback: @escaping(_ locations: [LocationModel]?)->Void){
//        let url = "\(baseUrl)search"
//
//        RequestService.shared.getFrom(url: url, parameters: ["query": lookFor as AnyObject], timeOutInterval: 20, headers: header, type: [LocationModel].self) { (data, error) in
//            if error == nil, let objc = data as? [LocationModel]{
//                Callback(objc)
//            }else{
//                Callback(nil)
//            }
//        }
//    }
    
    
}

//
//  RequestService.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 27/09/22.
//

import Foundation
import Alamofire


class RequestService{
    
    private let manager = NetworkReachabilityManager(host: "www.apple.com")

    static var shared: RequestService{
        let apiRequest = RequestService()
        return apiRequest
    }
    
    func post<T : Decodable>(url: String, paremeters: [String : AnyObject]?, timeOut: Int?, type: T.Type, method: HTTPMethod = .post, headers: HTTPHeaders? = nil, Callback: @escaping (AnyObject?, Error?) -> Void) {
        
        guard isNetworkReachable() else {
            Callback(nil, nil)
            return
        }
        
        AF.request(url, method: method, parameters: paremeters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let json = response.data{
                do{
                    if let arrayObjc = response.value as? [String:AnyObject]{
                        print(arrayObjc)
                    }
                    
                    let result = try JSONDecoder().decode(T.self, from: json)
                    
                    Callback(result as AnyObject, nil)
                }
                catch let myError {
                    Callback(nil, nil)
                    print("caught: \(myError)")
                }
            }else{
                Callback(nil, nil)
            }
        }
    }
    
    func getFrom<T : Decodable>(url: String,
                                parameters: [String : AnyObject]? = nil,
                                timeOutInterval: Int?,
                                headers: HTTPHeaders,
                                type: T.Type,
                                Callback: @escaping (AnyObject?, Error?) -> Void) {
        
        guard isNetworkReachable() else {
            Callback(nil, nil)
            return
        }
        
        AF.request(url, parameters: parameters, headers: headers).responseJSON { (response) in
            if let json = response.data{
                do{
                    let result = try JSONDecoder().decode(T.self, from: json)
                    Callback(result as AnyObject, nil)
                    
                }
                catch let myError {
                    Callback(nil, nil)
                    print("caught: \(myError)")
                }
            }else{
                Callback(nil, nil)
            }
        }
    }
    
    func isNetworkReachable() -> Bool {
        return manager?.isReachable ?? false
    }

}


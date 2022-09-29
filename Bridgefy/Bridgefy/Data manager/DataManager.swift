//
//  DataManager.swift
//  Bridgefy
//
//  Created by Jairo Lopez on 29/09/22.
//

import Foundation
import CoreData
import UIKit

class DataManager{
    
    static var shared: DataManager{
        let apiRequest = DataManager()
        return apiRequest
    }
    
    var entity: [NSManagedObject] = []
    private let countryTable = "Country"
    
    func save(country: CountryDetailModel) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: countryTable, in: managedContext)!
        
        let location = NSManagedObject(entity: entity, insertInto: managedContext)
        
        location.setValue(country.name, forKeyPath: "name")
        location.setValue(country.alpha2Code, forKeyPath: "alpha2Code")
        location.setValue(country.alpha3Code, forKeyPath: "alpha3Code")
        location.setValue(country.region, forKeyPath: "region")
        location.setValue(country.capital, forKeyPath: "capital")
        location.setValue(country.nativeName, forKeyPath: "nativeName")
        location.setValue(country.population, forKeyPath: "population")
        location.setValue(country.subregion, forKeyPath: "subregion")
        location.setValue(country.borders, forKeyPath: "borders")
        location.setValue(country.callingCodes, forKeyPath: "callingcodes")
        location.setValue(country.timezones, forKeyPath: "timezones")
        location.setValue(country.latlng, forKeyPath: "latlng")
        location.setValue(country.languages.map({$0.name}), forKeyPath: "languages")
        location.setValue(country.flags.png, forKeyPath: "urlimage")
        location.setValue(country.currencies.first?.code, forKeyPath: "exchange")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveCountryBy(_ name: String)-> CountryDetailModel?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: countryTable)
        
        do {
            var countries = [CountryDetailModel]()
            entity = try managedContext.fetch(fetchRequest)
            
            entity.forEach { object in
                var country = CountryDetailModel()
                
                country.name = object.value(forKeyPath: "name") as? String ?? ""
                country.alpha2Code = object.value(forKeyPath: "alpha2Code") as? String ?? ""
                country.alpha3Code = object.value(forKeyPath: "alpha3Code") as? String ?? ""
                country.region = object.value(forKeyPath: "region") as? String ?? ""
                country.capital = object.value(forKeyPath: "capital") as? String ?? ""
                country.nativeName = object.value(forKeyPath: "nativeName") as? String ?? ""
                country.population = object.value(forKeyPath: "population") as? Int ?? 0
                country.subregion = object.value(forKeyPath: "subregion") as? String ?? ""
                country.borders = object.value(forKeyPath: "borders") as? [String] ?? [""]
                country.callingCodes = object.value(forKeyPath: "callingcodes") as? [String] ?? [""]
                country.timezones = object.value(forKeyPath: "timezones") as? [String] ?? nil
                country.latlng = object.value(forKeyPath: "latlng") as? [Double] ?? [0.0,0.0]
                country.flags.png = object.value(forKeyPath: "urlimage") as? String ?? ""
                country.currencies = [Currencies(code: object.value(forKeyPath: "exchange") as? String ?? "")]
                
                let calCodes = (object.value(forKeyPath: "languages") as? [String] ?? [""])
                var languages = [LanguagesModel]()
                
                calCodes.forEach { code in
                    languages.append(LanguagesModel(name: code))
                }
                
                country.languages = languages
                
                if country.name != ""{
                    countries.append(country)
                }
            }
            
            return countries.first(where: { $0.name == name })
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func delete(name: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: countryTable)
        
        fetchRequest.predicate = NSPredicate(format: "any name == %@", name)
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for obj in objects {
                managedContext.delete(obj)
            }
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}

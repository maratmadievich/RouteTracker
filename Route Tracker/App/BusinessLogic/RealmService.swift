//
//  RealmService.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 21/07/2019.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    
    private init(){}
    
    internal func save(coordinates: [Coordinate]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.deleteAll()
            realm.add(coordinates)
            try realm.commitWrite()
        }
        catch {
            print("Realm save error: \(error)")
        }
    }
    
    internal func getCoordinates() -> [Coordinate]? {
        do {
            let realm = try Realm()
            let result = realm.objects(Coordinate.self)
            return result.count > 0
                ? convertToMassive(result: result)
                : nil
        }
        catch {
            print("Realm get coordinates error: \(error)")
            return nil
        }
    }
    
    private func convertToMassive(result: Results<Coordinate>) -> [Coordinate] {
        return result.map({ $0 })
    }
        
}

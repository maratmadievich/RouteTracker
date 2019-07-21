//
//  LocalRouteFactory.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 21/07/2019.
//

import Foundation
import GoogleMaps

class LocalRouteFactory {
    
    public func savePath(from routePath: GMSMutablePath?) {
        guard let coordinates = getCoordinates(from: routePath) else { return }
        RealmService.shared.save(coordinates: coordinates)
    }
    
    public func getPath() -> GMSMutablePath? {
        guard let coordinates = RealmService.shared.getCoordinates() else {
            return nil
        }
        return getPath(from: coordinates)
    }
    
    private func getCoordinates(from routePath: GMSMutablePath?) -> [Coordinate]? {
        guard let path = routePath,
            path.count() > 0 else {return nil}
        var coordinates = [Coordinate]()
        for i in 0..<path.count(){
            let coordinate = Coordinate()
            coordinate.latitude = path.coordinate(at: i).latitude
            coordinate.longitude = path.coordinate(at: i).longitude
            coordinates.append(coordinate)
        }
        return coordinates
    }
    
    private func getPath(from coordinates: [Coordinate]) -> GMSMutablePath {
        let path = GMSMutablePath()
        for coordinate in coordinates {
            path.add(CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        return path
    }
}

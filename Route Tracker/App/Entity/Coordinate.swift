//
//  LocalCoordinate.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 21/07/2019.
//

import Foundation
import RealmSwift

// Define your models like regular Swift classes
class Coordinate: Object {
    @objc dynamic var longitude: Double = 0
    @objc dynamic var latitude: Double = 0
}

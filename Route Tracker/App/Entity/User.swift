//
//  User.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import Foundation
import RealmSwift

class User: Object {
	@objc dynamic var login: String = ""
	@objc dynamic var password: String = ""
	
	override static func primaryKey() -> String? {
		return "login"
	}
}

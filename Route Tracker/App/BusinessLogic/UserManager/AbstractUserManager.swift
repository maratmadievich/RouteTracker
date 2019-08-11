//
//  AbstractUserManager.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import Foundation

protocol AbstractUserManager {
	func saveUser(with login: String, password: String)
	func getPassword(for login: String) -> String?
	func validateUser(by login: String, and password: String) -> Bool
}

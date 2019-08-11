//
//  UserManagerFactory.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import Foundation

class UserManagerFactory {
	
	func makeUserManager() -> AbstractUserManager {
		return RealmUserManager()
	}
	
}

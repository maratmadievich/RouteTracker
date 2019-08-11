//
//  RealmUserManager.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import Foundation
import RealmSwift

class RealmUserManager: AbstractUserManager {
	
	internal func saveUser(with login: String, password: String) {
		do {
			let realm = try Realm()
			guard let user = realm.objects(User.self).filter({ $0.login == login}).first else {
				 createUser(with: login, and: password)
				return
			}
			try! realm.write {
				user.password = password
			}
		}
		catch {
			print("Realm save error: \(error)")
		}
	}
	
	private func getUser(with login: String, and password: String) -> User {
		let user = User()
		user.login = login
		user.password = password
		return user
	}
	
	private func createUser(with login: String, and password: String) {
		let user = getUser(with: login, and: password)
		do {
			let realm = try Realm()
			realm.beginWrite()
			realm.add(user)
			try realm.commitWrite()
		}
		catch {
			print("Realm create error: \(error)")
		}
	}
	
	internal func getPassword(for login: String) -> String? {
		do {
			let realm = try Realm()
			guard let user = realm.objects(User.self)
				.filter({ $0.login == login}).first else { return nil }
			return user.password
		}
		catch {
			print("Realm get password error: \(error)")
			return nil
		}
	}
	
	internal func validateUser(by login: String, and password: String) -> Bool {
		do {
			let realm = try Realm()
			let users = realm.objects(User.self).filter({ $0.login == login && $0.password == password})
			return users.count > 0
		}
		catch {
			print("Realm validate error: \(error)")
			return false
		}
	}
	
}

//
//  LoginRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

final class LoginRouter: BaseRouter {
	
	func showMain() {
		let controller = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(MainViewController.self)
		setAsRoot(UINavigationController(rootViewController: controller))
	}
	
	func showRegistration() {
		let controller = UIStoryboard(name: "Registration", bundle: nil)
			.instantiateViewController(RegistrationViewController.self)
		show(controller)
	}
	
	func showRecovery() {
		let controller = UIStoryboard(name: "Recovery", bundle: nil)
			.instantiateViewController(RecoveryViewController.self)
		show(controller)
	}
}

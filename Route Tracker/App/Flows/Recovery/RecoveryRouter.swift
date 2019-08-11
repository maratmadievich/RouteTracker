//
//  RecoveryRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

final class RecoveryRouter: BaseRouter {
	
	func showLogin() {
		let controller = UIStoryboard(name: "Login", bundle: nil)
			.instantiateViewController(LoginViewController.self)
		setAsRoot(UINavigationController(rootViewController: controller))
	}
	
}

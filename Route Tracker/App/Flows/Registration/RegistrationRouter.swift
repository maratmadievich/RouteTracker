//
//  RegistrationRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

final class RegistrationRouter: BaseRouter {
	
	func showMain() {
		let controller = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(MainViewController.self)
		setAsRoot(UINavigationController(rootViewController: controller))
	}
	
}

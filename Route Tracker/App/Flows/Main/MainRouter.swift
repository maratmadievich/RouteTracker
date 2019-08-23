//
//  MainRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

final class MainRouter: BaseRouter {
	
	func showMap() {
		let controller = UIStoryboard(name: "Map", bundle: nil)
			.instantiateViewController(MapViewController.self)
		show(controller)
	}
	
	func logout() {
		let controller = UIStoryboard(name: "Login", bundle: nil)
			.instantiateViewController(LoginViewController.self)
		setAsRoot(UINavigationController(rootViewController: controller))
	}
	
}

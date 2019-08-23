//
//  MainRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import RxSwift
import RxCocoa

final class MainRouter: BaseRouter {
	
	func showMap(observable: BehaviorSubject<UIImage?>) {
		let controller = UIStoryboard(name: "Map", bundle: nil)
			.instantiateViewController(MapViewController.self)
		controller.avatarObservable = observable
		show(controller)
	}
	
	func logout() {
		let controller = UIStoryboard(name: "Login", bundle: nil)
			.instantiateViewController(LoginViewController.self)
		setAsRoot(UINavigationController(rootViewController: controller))
	}
	
	func showSelfie(image: UIImage) {
		let controller = UIStoryboard(name: "Selfie", bundle: nil)
			.instantiateViewController(SelfieViewController.self)
		controller.image = image
		show(controller)
	}
	
}

//
//  BaseRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

class BaseRouter: NSObject {
	@IBOutlet weak var controller: UIViewController!
	
	func show(_ controller: UIViewController) {
		self.controller.show(controller, sender: nil)
	}
	
	func present(_ controller: UIViewController) {
		self.controller.present(controller, animated: true)
	}
	
	func setAsRoot(_ controller: UIViewController) {
		UIApplication.shared.keyWindow?.rootViewController = controller
	}
	
}

//
//  RegistrationCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class RegistrationCoordinator: BaseCoordinator {
	
	var rootController: UINavigationController?
	var onFinishFlow: (() -> Void)?
	
	override func start() {
		showRegistrationModule()
	}
	
	private func showRegistrationModule() {
		let controller = UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(RegistrationViewController.self)
		
		controller.onLogin = { [weak self] in
			self?.onFinishFlow?()
		}
		rootController?.pushViewController(controller, animated: true)
	}
	
}

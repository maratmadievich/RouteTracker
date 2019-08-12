//
//  LoginCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
	
	var rootController: UINavigationController?
	var onFinishFlow: (() -> Void)?
	
	override func start() {
		showLoginModule()
	}
	
	private func showLoginModule() {
		let controller = UIStoryboard(name: "Login", bundle: nil)
			.instantiateViewController(LoginViewController.self)
		
		controller.onRecovery = { [weak self] in
			self?.showRecoveryModule()
		}
		
		controller.onRegistration = { [weak self] in
			self?.showRegistrationModule()
		}
		
		controller.onMain = { [weak self] in
			self?.onFinishFlow?()
		}
		
		let rootController = UINavigationController(rootViewController: controller)
		setAsRoot(rootController)
		self.rootController = rootController
	}
	
	private func showRecoveryModule() {
		let coordinator = RecoveryCoordinator()
		coordinator.rootController = rootController
		coordinator.onFinishFlow = { [weak self, weak coordinator] in
			self?.removeDependency(coordinator)
			self?.start()
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
	private func showRegistrationModule() {
		let coordinator = RegistrationCoordinator()
		coordinator.rootController = rootController
		coordinator.onFinishFlow = { [weak self, weak coordinator] in
			self?.removeDependency(coordinator)
			self?.start()
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
}

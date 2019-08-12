//
//  ApplicationCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
	
	override func start() {
		UserDefaults.standard.bool(forKey: "isLogin")
			? toMain()
			: toLogin()
	}
	
	private func toMain() {
		let coordinator = MainCoordinator()
		coordinator.onFinishFlow = { [weak self, weak coordinator] in
			self?.removeDependency(coordinator)
			self?.start()
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
	private func toLogin() {
		let coordinator = LoginCoordinator()
		coordinator.onFinishFlow = { [weak self, weak coordinator] in
			self?.removeDependency(coordinator)
			self?.start()
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
}

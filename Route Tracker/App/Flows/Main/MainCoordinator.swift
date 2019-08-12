//
//  MainCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
	
	var rootController: UINavigationController?
	var onFinishFlow: (() -> Void)?
	
	override func start() {
		showMainModule()
	}
	
	private func showMainModule() {
		let controller = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(MainViewController.self)
		
		controller.onMap = { [weak self] usseles in
			self?.showMapModule(usseles: usseles)
		}
		
		controller.onLogout = { [weak self] in
			self?.onFinishFlow?()
		}
		
		let rootController = UINavigationController(rootViewController: controller)
		setAsRoot(rootController)
		self.rootController = rootController
	}
	
	private func showMapModule(usseles: String) {
		let coordinator = MapCoordinator()
		coordinator.rootController = rootController
		coordinator.onFinishFlow = { [weak self, weak coordinator] in
			self?.removeDependency(coordinator)
			self?.start()
		}
		addDependency(coordinator)
		coordinator.start()
	}
	
}

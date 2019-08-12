//
//  BaseCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

// Абстрактный класс-координатор
class BaseCoordinator {
	
	var childCoordinators: [BaseCoordinator] = []
	
	func start() {
		// Переопределить в наследниках
	}
	
	func addDependency(_ coordinator: BaseCoordinator) {
		for element in childCoordinators where element === coordinator {
			return
		}
		childCoordinators.append(coordinator)
	}
	
	func removeDependency(_ coordinator: BaseCoordinator?) {
		guard
			childCoordinators.isEmpty == false,
			let coordinator = coordinator
			else { return }
		
		for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
			childCoordinators.remove(at: index)
			break
		}
	}
	
	func setAsRoot(_ controller: UIViewController) {
		UIApplication.shared.keyWindow?.rootViewController = controller
	}
}

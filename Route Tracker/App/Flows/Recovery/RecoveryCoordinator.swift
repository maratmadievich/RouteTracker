//
//  RecoveryCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class RecoveryCoordinator: BaseCoordinator {
	
	var rootController: UINavigationController?
	var onFinishFlow: (() -> Void)?
	
	override func start() {
		showRecoveryModule()
	}
	
	private func showRecoveryModule() {
		let controller = UIStoryboard(name: "Recovery", bundle: nil)
			.instantiateViewController(RecoveryViewController.self)
		
		controller.onLogin = { [weak self] in
			self?.onFinishFlow?()
		}
		rootController?.pushViewController(controller, animated: true)
	}
	
}


//
//  MapCoordinator.swift
//  Route Tracker
//
//  Created by Admin on 8/12/19.
//

import UIKit

final class MapCoordinator: BaseCoordinator {
	
	var rootController: UINavigationController?
	var onFinishFlow: (() -> Void)?
	
	override func start() {
		showMapModule()
	}
	
	private func showMapModule() {
		let controller = UIStoryboard(name: "Map", bundle: nil)
			.instantiateViewController(MapViewController.self)
		rootController?.pushViewController(controller, animated: true)
	}
	
}

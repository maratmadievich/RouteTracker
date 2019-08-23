//
//  RecoveryRouter.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit

final class RecoveryRouter: BaseRouter {
	
	func showLogin() {
		_ = controller.navigationController?.popViewController(animated: true)
	}
	
}

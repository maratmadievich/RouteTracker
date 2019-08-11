//
//  MainViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import PinLayout

class MainViewController: UIViewController {
	
	@IBOutlet weak var buttonMap: UIButton!
	@IBOutlet weak var buttonLogout: UIButton!
	@IBOutlet weak var router: MainRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Главная"
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
    
	@IBAction func buttonMapTapped(_ sender: Any) {
		router.showMap()
	}
	
	@IBAction func buttonLogoutTapped(_ sender: Any) {
		UserDefaults.standard.set(false, forKey: "isLogin")
		router.logout()
	}

}

extension MainViewController {
	
	private func configureLayout() {
		buttonMap.pin
			.left(20).right(20)
			.top(200).height(6%)
		
		buttonLogout.pin
			.below(of: buttonMap)
			.left(20).right(20)
			.marginTop(10).height(7%)
	}
	
}

//
//  RegistrationViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import PinLayout

class RegistrationViewController: UIViewController {

	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	
	@IBOutlet weak var buttonRegistration: UIButton!
	
	private let userManager = UserManagerFactory().makeUserManager()
	
	internal var onLogin: (() -> Void)?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Регистрация"
    }
    
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	@IBAction func buttonRegistrationTapped(_ sender: Any) {
		registrateUser()
	}
	
	private func registrateUser() {
		guard let login = textFieldLogin.text,
			let password = textFieldPass.text else { return }
		userManager.saveUser(with: login, password: password)
		onLogin?()
	}

}

extension RegistrationViewController {
	
	private func configureLayout() {
		textFieldLogin.pin
			.left(20).right(20)
			.top(80).height(6%)
		
		textFieldPass.pin
			.below(of: textFieldLogin)
			.left(20).right(20)
			.marginTop(10).height(6%)
		
		buttonRegistration.pin
			.below(of: textFieldPass)
			.left(20).right(20)
			.marginTop(10).height(7%)
	}
	
}


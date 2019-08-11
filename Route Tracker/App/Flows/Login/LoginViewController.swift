//
//  LoginViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import PinLayout

class LoginViewController: UIViewController {
	
	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var textFieldPass: UITextField!
	
	@IBOutlet weak var buttonLogin: UIButton!
	@IBOutlet weak var buttonRegistration: UIButton!
	@IBOutlet weak var buttonRecovery: UIButton!
	@IBOutlet weak var router: LoginRouter!

	let userManager = UserManagerFactory().makeUserManager()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		configureViews()
    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureViews() {
		navigationItem.title = "Авторизация"
		textFieldLogin.autocorrectionType = .no
		textFieldPass.autocorrectionType = .no
	}
	
	@IBAction func buttonLoginTapped(_ sender: Any) {
		validateUser()
	}
	
	@IBAction func buttonRecoveryTapped(_ sender: Any) {
		router.showRecovery()
	}
	
	@IBAction func buttonRegistrationTapped(_ sender: Any) {
		router.showRegistration()
	}
	
	// Unwind segue для выхода автоматически удаляет флаг авторизации
	@IBAction func logout(_ segue: UIStoryboardSegue) {
		UserDefaults.standard.set(false, forKey: "isLogin")
	}
	
	private func validateUser() {
		guard let login = textFieldLogin.text,
			let password = textFieldPass.text else { return }
		if userManager.validateUser(by: login, and: password) {
			UserDefaults.standard.set(true, forKey: "isLogin")
			router.showMain()
		} else {
			show(error: "Пользователь не найден")
		}
	}
	
	private func show(error: String) {
		let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .cancel)
		alert.addAction(ok)
		present(alert, animated: true)
	}
	
}



extension LoginViewController {
	
	private func configureLayout() {
		textFieldLogin.pin
			.left(20).right(20)
			.top(80).height(6%)
		
		textFieldPass.pin
			.below(of: textFieldLogin)
			.left(20).right(20)
			.marginTop(10).height(6%)
		
		buttonLogin.pin
			.below(of: textFieldPass)
			.left(20).right(20)
			.marginTop(10).height(7%)
		
		buttonRegistration.pin
			.below(of: buttonLogin)
			.left(20).right(20)
			.marginTop(10).height(7%)
		
		buttonRecovery.pin
			.below(of: buttonRegistration)
			.left(20).right(20)
			.marginTop(10).height(7%)
	}
	
}

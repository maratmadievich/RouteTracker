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

	private let userManager = UserManagerFactory().makeUserManager()
	
	internal var onMain: (() -> Void)?
	internal var onRecovery: (() -> Void)?
	internal var onRegistration: (() -> Void)?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Авторизация"
    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	@IBAction func buttonLoginTapped(_ sender: Any) {
		validateUser()
	}
	
	@IBAction func buttonRecoveryTapped(_ sender: Any) {
		onRecovery?()
	}
	
	@IBAction func buttonRegistrationTapped(_ sender: Any) {
		onRegistration?()
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
			onMain?()
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

//
//  RecoveryViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import PinLayout

class RecoveryViewController: UIViewController {

	@IBOutlet weak var textFieldLogin: UITextField!
	@IBOutlet weak var buttonRecovery: UIButton!
	
	private let userManager = UserManagerFactory().makeUserManager()
	
	internal var onLogin: (() -> Void)?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Восстановление пароля"
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
    
	@IBAction func buttonRecoveryTapped(_ sender: Any) {
		getPassword()
	}
	
	private func getPassword() {
		guard let login = textFieldLogin.text,
			let password = userManager.getPassword(for: login) else {
				show(error: "Отсутствует пароль")
				return
		}
		show(password: password)
	}
	
	private func show(password: String) {
		let alert = UIAlertController(title: "Пароль", message: password, preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
			self?.onLogin?()
		})
		alert.addAction(ok)
		present(alert, animated: true)
	}
	
	private func show(error: String) {
		let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .cancel)
		alert.addAction(ok)
		present(alert, animated: true)
	}

}

extension RecoveryViewController {
	
	private func configureLayout() {
		textFieldLogin.pin
			.left(20).right(20)
			.top(80).height(6%)
		
		buttonRecovery.pin
			.below(of: textFieldLogin)
			.left(20).right(20)
			.marginTop(10).height(7%)
	}
	
}

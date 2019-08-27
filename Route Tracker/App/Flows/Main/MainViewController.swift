//
//  MainViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 10/08/2019.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout

class MainViewController: UIViewController {
	
	@IBOutlet weak var buttonMap: UIButton!
	@IBOutlet weak var buttonLogout: UIButton!
	@IBOutlet weak var buttonSelfie: UIButton!
	
	@IBOutlet weak var router: MainRouter!
	
	var avatarObservable = BehaviorSubject<UIImage?>(value: ImageStorage().getImage())

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Главная"
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
    
	@IBAction func buttonMapTapped(_ sender: Any) {
		router.showMap(observable: avatarObservable)
	}
	
	@IBAction func buttonLogoutTapped(_ sender: Any) {
		UserDefaults.standard.set(false, forKey: "isLogin")
		router.logout()
	}
	
	@IBAction func buttonSelfieTapped(_ sender: Any) {
		openCamera()
	}
	
	private func openCamera() {
		guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
		// Создаём контроллер и настраиваем его
		let imagePickerController = UIImagePickerController()
		// Источник изображений: камера
		imagePickerController.sourceType = .camera
		// Изображение можно редактировать
		imagePickerController.allowsEditing = true
		imagePickerController.delegate = self
		
		// Показываем контроллер
		present(imagePickerController, animated: true)
	}
	
	
}

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = extractImage(from: info) else { return }
		picker.dismiss(animated: true)
		avatarObservable.onNext(image)
		router.showSelfie(image: image)
	}
	
	// Метод, извлекающий изображение
	private func extractImage(from info: [UIImagePickerController.InfoKey : Any]) -> UIImage? {
		// Пытаемся извлечь отредактированное изображение
		if let image = info[.editedImage] as? UIImage {
			return image
			// Пытаемся извлечь оригинальное
		} else if let image = info[.originalImage] as? UIImage {
			return image
		} else {
			return nil
		}
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
		
		buttonSelfie.pin
			.below(of: buttonLogout)
			.left(20).right(20)
			.marginTop(10).height(7%)
	}
	
}

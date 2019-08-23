//
//  AppDelegate.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 30/06/2019.
//

import UIKit
import GoogleMaps
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGoogleMaps()
		showStartController()
		setupNotificationAccess()
        return true
    }
    
    private func configureGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyBcfZi_qJP32fqzNy6IbgpHiUzY1GGD9xA")
    }
	
	private func showStartController() {
		let controller: UIViewController
		if UserDefaults.standard.bool(forKey: "isLogin") {
			controller = UIStoryboard(name: "Main", bundle: nil)
				.instantiateViewController(MainViewController.self)
		} else {
			controller = UIStoryboard(name: "Login", bundle: nil)
				.instantiateViewController(LoginViewController.self)
		}
		window = UIWindow()
		window?.rootViewController = UINavigationController(rootViewController: controller)
		window?.makeKeyAndVisible()
	}
	
	func setupNotificationAccess() {
		let center = UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
			granted
				? print("Доступ к уведомлениям получен")
				: print("Доступ не получен")
		}
	}
	
	func makeNotificationContent() -> UNNotificationContent {
		// Внешний вид уведомления
		let content = UNMutableNotificationContent()
		// Заголовок
		content.title = "Вас долго нет..."
		// Подзаголовок
		content.subtitle = "Мы соскучились"
		// Основное сообщение
		content.body = "Вы давно не заходили в приложение"
		// Цифра в бейдже на иконке
		content.badge = 4
		return content
	}
	
	func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
		return UNTimeIntervalNotificationTrigger(
			// Количество секунд до показа уведомления
			timeInterval: 60 * 30,
			// Надо ли повторять
			repeats: false
		)
	}
	
	func sendNotificatioRequest(
		content: UNNotificationContent,
		trigger: UNNotificationTrigger) {
		
		// Создаём запрос на показ уведомления
		let request = UNNotificationRequest(
			identifier: "alaram",
			content: content,
			trigger: trigger
		)
		
		let center = UNUserNotificationCenter.current()
		// Добавляем запрос в центр уведомлений
		center.add(request) { error in
			// Если не получилось добавить запрос,
			// показываем ошибку, которая при этом возникла
			if let error = error {
				print(error.localizedDescription)
			}
		}
	}


    func applicationWillResignActive(_ application: UIApplication) {
		///Добавить blurEffect
		window?.rootViewController?.view.alpha = 0
		createReturnNotification()
	}

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) {
		///Убрать blurEffect
		window?.rootViewController?.view.alpha = 1
	}

    func applicationWillTerminate(_ application: UIApplication) {
		createReturnNotification()
	}
	
	private func createReturnNotification() {
		let center = UNUserNotificationCenter.current()
		center.getNotificationSettings { settings in
			switch settings.authorizationStatus {
			case .authorized:
				self.sendNotificatioRequest(
					content: self.makeNotificationContent(),
					trigger: self.makeIntervalNotificatioTrigger()
				)
			default:
				print("Нет разрешения на отправку уведомлений")
			}
		}
	}
	
	
}


//
//  AppDelegate.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 30/06/2019.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGoogleMaps()
		showStartController()
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

    func applicationWillResignActive(_ application: UIApplication) {
		///Добавить blurEffect
		window?.rootViewController?.view.alpha = 0
	}

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) {
		///Убрать blurEffect
		window?.rootViewController?.view.alpha = 1
	}

    func applicationWillTerminate(_ application: UIApplication) { }
	
}


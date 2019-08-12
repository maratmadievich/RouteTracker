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
	var coordinator: ApplicationCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGoogleMaps()
		showStartController()
        return true
    }
    
    private func configureGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyBcfZi_qJP32fqzNy6IbgpHiUzY1GGD9xA")
    }
	
	private func showStartController() {
//		let controller: UIViewController
//		if UserDefaults.standard.bool(forKey: "isLogin") {
//			controller = UIStoryboard(name: "Main", bundle: nil)
//				.instantiateViewController(MainViewController.self)
//		} else {
//			controller = UIStoryboard(name: "Login", bundle: nil)
//				.instantiateViewController(LoginViewController.self)
//		}
		window = UIWindow()
		window?.makeKeyAndVisible()
		coordinator = ApplicationCoordinator()
		coordinator?.start()

	}

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
	
}


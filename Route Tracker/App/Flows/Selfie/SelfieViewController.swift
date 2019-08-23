//
//  SelfieViewController.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 23/08/2019.
//

import UIKit
import PinLayout

class SelfieViewController: UIViewController {
	
	@IBOutlet weak var selfieImageView: UIImageView!
	var image: UIImage?


    override func viewDidLoad() {
        super.viewDidLoad()
		configureViews()
		guard let image = image else { return }
		print("save image: \(ImageStorage().save(image: image))")
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureViews() {
		selfieImageView.image = image
		navigationItem.title = "Просмотр селфи"
	}
	
	

}

extension SelfieViewController {
	
	private func configureLayout() {
		selfieImageView.pin.all()
	}
	
}

//
//  ImageStorage.swift
//  Route Tracker
//
//  Created by Марат Нургалиев on 23/08/2019.
//

import UIKit

class ImageStorage {
	
	private var selfieImamgeName = "routeTrackerSelfie.png"
	
	public func save(image: UIImage) -> Bool {
		guard let data = image.pngData(),
			let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
				return false
		}
		do {
			try data.write(to: directory.appendingPathComponent(selfieImamgeName)!, options: .atomic)
			return true
		} catch {
			print(error.localizedDescription)
			return false
		}
	}
	
	
	public func getImage() -> UIImage? {
		if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
			return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(selfieImamgeName).path)
		}
		return nil
	}
	
}

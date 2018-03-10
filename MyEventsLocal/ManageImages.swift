//
//  ManageImages.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 4/6/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import Foundation
import RealmSwift

class  ManageImages {
	
	//static let imageName: String = ""
	
	func loadImage(imageID: String) -> UIImage? {
		
		// Get the image back
		let imageName:String = imageID
		let imagePath = fileInDocumentsDirectory(imageName)
		
		if let loadedImage = loadImageFromPath(imagePath) {
			return loadedImage
		} else {
			
			print("Couldn't Load: \(imageName)")
			return nil
		}
		
	}
	
	func loadImageFromPath(_ path: String) -> UIImage? {
		
		let image = UIImage(contentsOfFile: path)
		
		if image == nil {
			print("couldn't find image at path: \(path)")
		}
		
		return image
		
	}
	
	func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
		
		let scale = newWidth / image.size.width
		
		let newHeight = image.size.height * scale
		
		UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
		
		image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return newImage!
		
	}
	
	func getDocumentsURL() -> URL {
		let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		return documentsURL
	}
	
	func fileInDocumentsDirectory(_ filename: String) -> String {
		
		let fileURL = getDocumentsURL().appendingPathComponent(filename)
		return fileURL.path
		
	}
	// returns the image path
	func saveReviewImage(imageID: String, image: UIImage) -> String {
		let newImage = resizeImage(image: image, newWidth: 1024.00)
		
		let imageFileName:String = imageID
		let imagePath = fileInDocumentsDirectory(imageFileName)
		saveImage(newImage, path: imagePath)
		return imagePath
	}
	
	// This will be your method to save image
	func saveImage(_ image: UIImage, path: String ) {
		
		//PNG is - let pngImageData = UIImagePNGRepresentation(image)
		
		if let jpgData = UIImageJPEGRepresentation(image, 1.0) {
			try? jpgData.write(to: URL(fileURLWithPath: path), options: [.atomic])
		}
		
	}

}


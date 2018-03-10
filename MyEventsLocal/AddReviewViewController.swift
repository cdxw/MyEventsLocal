//
//  AddReviewViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 20/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit
import RealmSwift

class AddReviewViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var displayEventNameLbl: UILabel!
	@IBOutlet weak var txtNameOfReview: UITextField!
	@IBOutlet weak var txtReviewDescription: UITextView!
	
	@IBOutlet weak var clickUploadLbl: UILabel!
	
	var getEvent = Event()
	var imagePic: UIImage = #imageLiteral(resourceName: "photoalbum")
	var manageImages = ManageImages()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayEventNameLbl.text = getEvent.eventName
		clickUploadLbl.text = "Click to upload Image"
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func saveReview(_ sender: Any) {
		
		let newReview = Review()
		//newReview.reviewerName = txtNameOfReview.text
		newReview.reviewDescription = txtReviewDescription.text
		
		guard let revDescription = txtReviewDescription.text, revDescription != "" else {
			missingFieldAlert(field: "Missing Description")
			return
		}
		
		if photoImageView.image != nil{
			newReview.reviewerName = manageImages.saveReviewImage(imageID: newReview.id, image: imagePic)
		}else{
			newReview.reviewerName = ""
		}
		
		
		let newEvent = Event()
		newEvent.id = getEvent.id
		newEvent.eventName = getEvent.eventName
		newEvent.eventDescription = getEvent.eventDescription
		newEvent.eventSuburb = getEvent.eventSuburb
		newEvent.eventStreetNumber = getEvent.eventStreetNumber
		newEvent.eventPostcode = getEvent.eventPostcode
		newEvent.eventStart = getEvent.eventStart
		newEvent.eventFinish = getEvent.eventFinish
		newEvent.eventStreet = getEvent.eventStreet
		
		
		for revs in getEvent.reviews{
			newEvent.reviews.append(revs)
		}
		
		// Add the new review to the current event
		newEvent.reviews.append(newReview)
		
		try!  DatabaseHelper.add(object: newEvent, update: true)
		
		goToController()
	}

	
	@IBAction func unwindToEvents(_ sender: Any) {
		goToController()
		
	}
	
	func goToController(){
		
		if let nvc = navigationController {
			
			nvc.popViewController(animated: true)
			
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

			
		} else {
			// otherwise, dismiss it
			dismiss(animated: true, completion: nil)
		}
	}


	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return 3
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 1 {
			if UIImagePickerController.isSourceTypeAvailable(.camera) {
				let imagePicker = UIImagePickerController()
				imagePicker.delegate = self
				imagePicker.allowsEditing = false
				imagePicker.sourceType = .camera
				
				
				present(imagePicker, animated: true, completion: nil)
			}
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
			photoImageView.image = selectedImage
			photoImageView.contentMode = .scaleAspectFill
			photoImageView.clipsToBounds = true
			imagePic = photoImageView.image!
			clickUploadLbl.text = ""
		}
		
		dismiss(animated: true, completion: nil)
	}
	
	
	func missingFieldAlert(field: String){
		
		let message = "Please fill in the missing field: \(field)"
		
		let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		optionMenu.addAction(cancelAction)
		
		// Display the menu
		present(optionMenu, animated: true, completion: nil)
		
	}

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
			if segue.identifier == "unwindToEventDetail" {
				if tableView.indexPathForSelectedRow != nil {
					let destinationController = segue.destination as! EventDetailsViewController
					destinationController.event = getEvent
				}
			}
	}


}

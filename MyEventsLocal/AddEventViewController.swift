//
//  AddEventViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 20/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit
import RealmSwift
import DateTimePicker

class AddEventViewController: UITableViewController {

	@IBOutlet weak var suburbInputField: UITextField!

		//@IBOutlet weak var finishInputField: UIDatePicker!
	//@IBOutlet weak var startInputField: UIDatePicker!
	@IBOutlet weak var descriptionInputField: UITextView!
	@IBOutlet weak var postcodeInputField: UITextField!
	@IBOutlet weak var streetInputField: UITextField!
	@IBOutlet weak var streetNoInputField: UITextField!
	@IBOutlet weak var finishLabel: UILabel!
	@IBOutlet weak var startLabel: UILabel!
	@IBOutlet weak var nameInputField: UITextField!
	
	
	@IBAction func btnFinishDate(_ sender: Any) {
		let picker = DateTimePicker.show()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM d, yyyy"
		picker.selectedDate = Date()
		
		picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
		picker.completionHandler = { date in
		
			let finish = dateFormatter.string(from: picker.selectedDate)
		self.finishLabel.text = finish
		}
	}
	
	@IBAction func btnStartDate(_ sender: Any) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMM d, yyyy"
		
		let picker = DateTimePicker.show()
		picker.selectedDate = Date()
		picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
		picker.completionHandler = { date in
			
			let start = dateFormatter.string(from: picker.selectedDate)
			self.startLabel.text = start
		}

	}
	

	@IBAction func btnAddEventButton(_ sender: Any) {
		
		
		// Validate the input fields
		
		if validateFields() {
			
			let newEvent = Event()
			newEvent.eventName = nameInputField.text
			newEvent.eventDescription = descriptionInputField.text
			newEvent.eventSuburb = suburbInputField.text
			newEvent.eventStreetNumber = streetNoInputField.text
			newEvent.eventPostcode = postcodeInputField.text
			newEvent.eventStart = startLabel.text
			newEvent.eventFinish = finishLabel.text
			newEvent.eventStreet = streetInputField.text
			
			
		try!  DatabaseHelper.add(object: newEvent, update: false)
			
			let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
			let eventVC = MainStoryboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsTableViewController
			self.navigationController?.pushViewController(eventVC, animated: true)
		}

	}
	// show an alert if a field is missing data
	func missingFieldAlert(field: String){
		
		let message = "Please fill in the missing field: \(field)"
		
		let optionMenu = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		optionMenu.addAction(cancelAction)
		
		// Display the menu
		present(optionMenu, animated: true, completion: nil)
		
	}
	// Check each field for input
	func validateFields() -> Bool{
		
		var isValid = true
		
		guard let nameField = nameInputField.text, nameField != "" else {
			missingFieldAlert(field: "Event Name")
			isValid = false
			return isValid
		}
		
		guard let startText = startLabel.text,  startText != "" else {
			missingFieldAlert(field: "Event Start Date")
			isValid = false
			return isValid
		}
		guard let finishText = finishLabel.text, finishText != "" else {
			missingFieldAlert(field: "Event Finish Date")
			isValid = false
			return isValid
		}
		guard let streetNo = streetNoInputField.text, streetNo != "" else {
			missingFieldAlert(field: "Event Street Number")
			isValid = false
			return isValid
		}
		guard let streetName = streetInputField.text, streetName != "" else {
			missingFieldAlert(field: "Event Street Name")
			isValid = false
			return isValid
		}
		guard let suburb = suburbInputField.text, suburb != "" else {
			missingFieldAlert(field: "Event Suburb")
			isValid = false
			return isValid
		}
		guard let postcode = postcodeInputField.text, postcode != "" else {
			missingFieldAlert(field: "Event Postcode")
			isValid = false
			return isValid
		}

		guard let description = descriptionInputField.text, description != "" else {
			missingFieldAlert(field: "Event Description")
			isValid = false
			return isValid
		}
		
		return isValid
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
			
			
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// hide keyboard when touching outside the keyboard
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	}

//
//  ContactViewController.swift
//  Assignment2
//
//  Created by Chris Williams on 31/3/17.
//  Copyright © 2017 Chris Williams. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UITableViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate  {

	
	@IBOutlet weak var usersName: UITextField!
	@IBOutlet weak var emailBody: UITextView!
	let _EMAILADDRESS = "chris@tonguesoutmedia.com"
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.tableView.contentInset = UIEdgeInsetsMake(60,0,0,0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
	
	// Send contact email to constant email address
	@IBAction func sendEmailButtonTapped(){
		
		let userNameinput: String? = usersName?.text ?? ""
		let emailBodyInput: String? = emailBody.text ?? ""
		
		// Check if the email services are available to use
		
		if !MFMailComposeViewController.canSendMail() {
			print("Mail services are not available")
			return
		}
		
		// check a contact name has been entered
		if userNameinput != "" {
			if MFMailComposeViewController.canSendMail(){
				let mail = MFMailComposeViewController()
				mail.mailComposeDelegate = self
				mail.setToRecipients([_EMAILADDRESS])
				mail.setSubject("Mail from:" + userNameinput!)
				mail.setMessageBody("<p>Enquiry: <p>" + "<br><p>" + emailBodyInput! + "<p>", isHTML: true)
				
				present(mail, animated: true, completion: nil)
			}else{
				self.showSendMailErrorAlert()
			}
		}else{
			// send an empty field alert
			let emptyFieldAlert = UIAlertController(title: "Error Blank Field", message: "Please enter a name", preferredStyle: .alert)
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				UIAlertAction in
			}
			emptyFieldAlert.addAction(okAction)
			
			self.present(emptyFieldAlert, animated: true, completion: nil)
			
		}
		
	}
	// Show an alert if the email fails to send
	func showSendMailErrorAlert() {
		let sendMailErrorAlert = UIAlertController(title: "Error sending Mail", message: "An Error Occured - sorry :(", preferredStyle: .alert)
		self.present(sendMailErrorAlert, animated: true, completion: nil)
		
	}
	
// dismiss the mail client once the mail email is sent
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		// statements for debug

		
		controller.dismiss(animated: true, completion: nil)
	}
	// hide keyboard when touching outside the keyboard
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	// Hide keyboard with return key
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
}

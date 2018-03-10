//
//  MenuViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 6/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

	@IBOutlet weak var backgroundImageView: UIImageView!
	
	@IBAction func closeMenu(_ sender: Any) {
		navigationController?.popViewController(animated: true)
		
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func goToEventsBtn(_ sender: Any) {
		
//		let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//		let eventVC = MainStoryboard.instantiateViewController(withIdentifier: "EventsViewController")
//		
//		self.navigationController?.pushViewController(eventVC, animated: true)
		goToController(controller: "EventsViewController")
	}
	
	@IBAction func goToHomeBtn(_ sender: Any) {
		
		goToController(controller: "HomeViewController")
		
	}
	
	@IBAction func goToContactBtn(_ sender: Any) {
		goToController(controller: "ContactViewController")
	}
	
	@IBAction func goToAddEventBtn(_ sender: Any) {
		goToController(controller: "AddEventViewController")
		
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// blur the background image
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = view.bounds
		backgroundImageView.addSubview(blurEffectView)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// This function navigates to the controller with string parameter
	func goToController(controller: String){
		
		if let nvc = navigationController {
			nvc.popViewController(animated: true)
		} else {
			// otherwise, dismiss it
			dismiss(animated: true, completion: nil)
		}
		
		let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
		let vc = MainStoryboard.instantiateViewController(withIdentifier: controller)
		
		self.navigationController?.pushViewController(vc, animated: true)
	}

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//			if segue.identifier == "EventsViewController" {
//				
//			}
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//    }


}

//
//  EventDetailsViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 20/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit
import MapKit

class EventDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate   {

	var event: Event!
	
	

	@IBOutlet weak var eventMapView: MKMapView!
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	@IBOutlet weak var eventTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
			
			// look for a notification to reload the page
				NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
			
			// get the geo location from GPS
			let geoCoder = CLGeocoder()
			
			geoCoder.geocodeAddressString(event.fullAddress, completionHandler: { placemarks, error in
    if let error = error {
			print(error)
			return
			
    }
				
    if let placemarks = placemarks {
			// Get the first placemark
			let placemark = placemarks[0]
			
			// Add annotation
			let annotation = MKPointAnnotation()
			annotation.title = self.event.eventName
			
			if let location = placemark.location {
				// Display the annotation
				annotation.coordinate = location.coordinate
				
				//self.eventMapView.addAnnotation(annotation)
				self.eventMapView.showAnnotations([annotation], animated: true)
				self.eventMapView.selectAnnotation(annotation, animated: true)
				// Set the zoom level
				let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
				self.eventMapView.setRegion(region, animated: false)
			}
				}
			}
			)
			
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// this function will reload the reviews in the collection view
	func loadList(notification: NSNotification){
		//load data here
		self.collectionView.reloadData()

	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventDetailTableViewCell
		// Configure the cell...
		switch indexPath.row {
		case 0:
			cell.fieldLabel.text = "Name"
			cell.valueLabel.text = event.eventName
		case 1:
			cell.fieldLabel.text = "Location"
			cell.valueLabel.text = event.fullAddress
		case 2:
			cell.fieldLabel.text = "Description"
			cell.valueLabel.text = event.eventDescription
			
		case 3:
			cell.fieldLabel.text = "Start Date"
			cell.valueLabel.text = event.eventStart
		case 4:
			cell.fieldLabel.text = "Finish Date"
			cell.valueLabel.text = event.eventFinish
			
		default:
			cell.fieldLabel.text = ""
			cell.valueLabel.text = ""
		}
		cell.backgroundColor = UIColor.clear
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		//print("Count is: \( event.reviews.count)")
		return event.reviews.count
		
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! EventCollectionViewCell
		
		
		return cell
	}
	
	// this func navigates to the Add review controller screen to add a new review
	@IBAction func touchedAddReviewBtn(_ sender: Any) {
		
		let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
		
		let addReviewVC = MainStoryboard.instantiateViewController(withIdentifier: "AddReviewController") as! AddReviewViewController
		
		addReviewVC.getEvent = event
		
		self.navigationController?.pushViewController(addReviewVC, animated: true)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
		let reviewDetailVC = MainStoryboard.instantiateViewController(withIdentifier: "EventReviewsDetailController") as! EventReviewTableViewController
		
		reviewDetailVC.getReview = event.reviews[indexPath.row]

		self.navigationController?.pushViewController(reviewDetailVC, animated: true)
		
	}

	

	
}


//
//  ViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 5/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift

class HomeViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {

	@IBOutlet weak var homeMapView: MKMapView!
	var manageImages = ManageImages()
	
	let annotation = MKPointAnnotation()
	var locationManager: CLLocationManager = CLLocationManager()
	
	// Get the current event items

	var eventItems: Results<Object>{
		get{
			let result = try? DatabaseHelper.query(for: Event.self, with: "")
			return result!!
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//homeMapView.showsUserLocation = true
		locationManager = CLLocationManager()
		locationManager.requestWhenInUseAuthorization()
		
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.delegate = self as CLLocationManagerDelegate
		locationManager.startUpdatingLocation()
		
		// Load seed data if realm has no entries
		guard let itemCount = try? DatabaseHelper.query(for: Event.self, with: "")?.count, itemCount != 0 else {
				addSeedData()
			return
		}
		
	}
	// This function adds seed data to the start of the App for project purposes
	func addSeedData() {
		
		// default images
		let bbqPic: UIImage = #imageLiteral(resourceName: "bbqImage")
		let garagePic: UIImage = #imageLiteral(resourceName: "garageSale")
		
		// Create review Objects
		let reviewGarage = Review(value: [UUID().uuidString,"Great variety of barry manalow records",""])
		let reviewBBQ = Review(value: [UUID().uuidString,"Stay away from this one",""])
		
		// get the image paths for the default images
		let revGarageImagePath = manageImages.saveReviewImage(imageID: reviewGarage.id, image: garagePic)
		let revBBQImagePath = manageImages.saveReviewImage(imageID: reviewBBQ.id, image: bbqPic)
		
		// add the path to the object
		reviewGarage.reviewerName = revGarageImagePath
		reviewBBQ.reviewerName = revBBQImagePath

		let eventGarage = Event(value: [ UUID().uuidString,"Garage Sale", "30/5/2017" ,"6/6/2017","Howick St", "296", "Bathurst", "2795" , "Dont come before 7am or else!"])
		// Add the review to the event
		eventGarage.reviews.append(reviewGarage)
		
		let eventBBQ = Event(value: [ UUID().uuidString,"Free BBQ", "30/5/2017","6/6/2017","William St", "220", "Bathurst", "2795" , "Come for the snags, stay for the salmonella"])
		// add the review to the event
		eventBBQ.reviews.append(reviewBBQ)
		
		// Add objects to realm
		try! DatabaseHelper.add(object: eventGarage, update: false)
		try! DatabaseHelper.add(object: eventBBQ, update: false)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// get the location of the user
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let lastLocation: CLLocation = locations[locations.count - 1]
		let lat = lastLocation.coordinate.latitude
		let long = lastLocation.coordinate.longitude
		
		addMarkersToMap(longitude: long, latitude: lat)
	}
	
	// add the notation pins to the map
	func addMarkersToMap(longitude: Double, latitude: Double)
	{
		let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let center = location
		let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
		homeMapView.setRegion(region, animated: true)
		homeMapView.addAnnotation(annotation)
		
	}
}


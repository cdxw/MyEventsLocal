//
//  Datasource.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 11/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//


import UIKit
import RealmSwift


final class Event: Object{
	dynamic var id = UUID().uuidString
	dynamic var eventName: String?
	dynamic var eventStart: String?
	dynamic var eventFinish: String?
	dynamic var eventStreet: String?
	dynamic var eventStreetNumber: String?
	dynamic var eventSuburb: String?
	dynamic var eventPostcode: String?
	dynamic var eventDescription: String?
	
	let reviews = List<Review>()
	
	var fullAddress: String{
		return "\(eventStreetNumber!) \(eventStreet!) \(eventSuburb!) \(eventPostcode!)"
		}
	
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
}


final class Review: Object{
	dynamic var id = UUID().uuidString
	dynamic var reviewDescription: String?
	dynamic var reviewerName: String?

	
	override static func primaryKey() -> String? {
		return "id"
	}

}

//
//  EventsTableViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 11/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit
import RealmSwift

class EventsTableViewController: UITableViewController {

	//var eventItems = List<Event>()
    
    var eventItems: Results<Object>{
        get{
           let result = try! DatabaseHelper.query(for: Event.self, with: "")
            return result!
        }
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.tableView.contentInset = UIEdgeInsetsMake(60,0,0,0)
			
		}
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
			//let count = try!(DatabaseHelper.query(for: Event.self, with: "")?.count)!
			return eventItems.count
    }

	
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
				let cellIdentifier = "Cell"
			
				let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventTableViewCell
			
                //let item = try! DatabaseHelper.query(for: Event.self, with: "")
				let item = eventItems[indexPath.row] as! Event
				//cell.textLabel?.text = item.eventName
			cell.titleLabel?.text = item.eventName
			cell.locationLabel?.text = item.fullAddress
			
			//cell.textLabel?.text = item.reviews[indexPath.row].reviewDescription
			//rev.append(item.reviews)
			
				return cell
    }
	
	// MARK: - Navigation
	func getDocumentsURL() -> URL {
		let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		return documentsURL
	}
	
	func fileInDocumentsDirectory(_ filename: String) -> String {
		
		let fileURL = getDocumentsURL().appendingPathComponent(filename)
		return fileURL.path
		
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			// Delete the row from the data source
			let item = eventItems[indexPath.row] as! Event
			
			try! DatabaseHelper.delete(object: item)
			
			tableView.deleteRows(at: [indexPath], with: .fade)
			
			
		} 
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showEventDetail" {

			if let indexPath = tableView.indexPathForSelectedRow {
				let destinationController = segue.destination as! EventDetailsViewController
				destinationController.event = eventItems[indexPath.row] as! Event
			}
	}
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
       */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
	}
	
	


}

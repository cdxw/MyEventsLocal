//
//  EventReviewTableViewController.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 28/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit

class EventReviewTableViewController: UITableViewController {

	var getReview = Review()
	
	var manageImages = ManageImages()
	
	@IBOutlet weak var reviewerNameLbl: UILabel!
	@IBOutlet weak var reviewDescription: UITextView!
	@IBOutlet weak var reviewImage: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

			reviewerNameLbl.text = "Event Review:"
			reviewDescription.text = getReview.reviewDescription
			
			//reviewImage.image =	loadImage(imageID: getReview.id)
			reviewImage.image = manageImages.loadImage(imageID: getReview.id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
//	func loadImage(imageID: String) -> UIImage? {
//		
//		// Get the image back
//		let imageName:String = imageID
//		let imagePath = fileInDocumentsDirectory(imageName)
//		
//		if let loadedImage = self.loadImageFromPath(imagePath) {
//			return loadedImage
//		} else {
//			print("Couldn't Load: \(imageName)")
//			return nil
//		}
//		
//	}
//	
	
//	func loadImageFromPath(_ path: String) -> UIImage? {
//		
//		let image = UIImage(contentsOfFile: path)
//		
//		if image == nil {
//			
//			print("couldn't find image at path: \(path)")
//		}
//		
//		return image
//		
//	}

//	func fileInDocumentsDirectory(_ filename: String) -> String {
//		
//		let fileURL = getDocumentsURL().appendingPathComponent(filename)
//		return fileURL.path
//		
//	}
//	
//	func getDocumentsURL() -> URL {
//		let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//		return documentsURL
//	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

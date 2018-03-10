//
//  EventDetailTableViewCell.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 20/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell {

	@IBOutlet var fieldLabel:UILabel!
	@IBOutlet var valueLabel:UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

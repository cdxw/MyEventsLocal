//
//  EventTableTableViewCell.swift
//  MyEventsLocal
//
//  Created by Chris Williams on 26/5/17.
//  Copyright © 2017 MyEventsLocal. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var locationLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

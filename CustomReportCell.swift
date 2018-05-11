//
//  CustomReportCell.swift
//  Volunteered Here
//
//  Created by Dad on 5/7/18.
//  Copyright © 2018 Jeff Kirshenbaum. All rights reserved.
//

import UIKit

class CustomReportCell: UITableViewCell {
    
    @IBOutlet weak var reportDate: UILabel!
    @IBOutlet weak var reportHours: UILabel!
    @IBOutlet weak var reportOrg: UILabel!
    @IBOutlet weak var reportDesc: UILabel!
    @IBOutlet weak var reportOrgEmail: UILabel!
    @IBOutlet weak var reportVerified: UIImageView!
    
    static let reuseIdentifier = "EventCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

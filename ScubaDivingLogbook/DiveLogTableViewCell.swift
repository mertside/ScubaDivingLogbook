//
//  DiveLogTableViewCell.swift
//  ScubaDivingLogbook
//
//  Created by Mert Şide on 15/03/2017.
//  Copyright © 2017 Mert Şide. All rights reserved.
//

import UIKit

class DiveLogTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var maxDepthLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var divingSpotLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    
    //TODO: link to story board...
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

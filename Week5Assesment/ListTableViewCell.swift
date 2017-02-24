//
//  ListTableViewCell.swift
//  Week5Assesment
//
//  Created by Kok Yong on 24/02/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var bikeShopLabel: UILabel!
    @IBOutlet weak var availableBikesLable: UILabel!
    @IBOutlet weak var distanceAwayLabel: UILabel!
    
    static let cellIdentifier = "ListTableViewCell"
    static let cellNib = UINib(nibName: "ListTableViewCell", bundle: Bundle.main)
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

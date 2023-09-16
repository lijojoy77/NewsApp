//
//  TVCHomeCell.swift
//  NewsApp
//
//  Created by Lijo Joy on 14/09/2023.
//

import UIKit

class TVCHomeCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblChannel: UILabel!
    @IBOutlet weak var backgrndView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgrndView.layer.cornerRadius = 10
        backgrndView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

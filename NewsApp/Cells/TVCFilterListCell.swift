//
//  TVCFilterListCell.swift
//  NewsApp
//
//  Created by Lijo Joy on 16/09/2023.
//

import UIKit

class TVCFilterListCell: UITableViewCell {

    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var lblFilterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

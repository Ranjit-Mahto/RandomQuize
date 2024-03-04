//
//  QueryViewCell.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

import UIKit

class QueryViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

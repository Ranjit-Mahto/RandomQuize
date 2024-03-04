//
//  AnswerViewCell.swift
//  QuizeTest
//
//  Created by Ranjit Mahto on 17/02/24.
//

import UIKit
//

struct imgCheck {
    static let select = "checkmark.circle.fill"
    static let unselect = "circle"
}

class AnswerViewCell: UITableViewCell {
    
    @IBOutlet weak var ivCorrect : UIImageView!
    @IBOutlet weak var lblAnswer : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

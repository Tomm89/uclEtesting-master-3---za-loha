//
//  SubjectTableCell.swift
//  E-testing
//
//  Created by Ondřej David on 09.08.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import UIKit
import FoldingCell

class SubjectTableCell: UITableViewCell {

    @IBOutlet weak var prctgNumberLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var prctgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

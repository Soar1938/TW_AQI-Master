//
//  aqiTableCell.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import UIKit

class aqiTableCell: UITableViewCell {

    @IBOutlet weak var aqiCellView: UIView!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var aqiValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

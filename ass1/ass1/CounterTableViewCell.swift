//
//  CounterTableViewCell.swift
//  ass1
//
//  Created by Hamza Mian on 2020-09-26.
//  Copyright © 2020 Hamza Mian. All rights reserved.
//

import UIKit
//TODO:Pass specific view to Var.
class CounterTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var counterLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

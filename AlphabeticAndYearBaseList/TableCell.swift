//
//  TableCell.swift
//  AlphabeticAndYearBaseList
//
// Created by Echo Innovate IT on 05/07/18.
//  Copyright © 2018 Echo. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    //MARK: - Variable Declaration
    
    /* Label */
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

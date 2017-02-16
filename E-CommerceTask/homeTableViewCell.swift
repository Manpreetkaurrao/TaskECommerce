//
//  homeTableViewCell.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 15/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit

class homeTableViewCell: UITableViewCell {

    @IBOutlet var lblListName: UILabel!
    var categories : String?
    {
        didSet
        {
            updateUI()
        }
    }
    fileprivate func updateUI()
    {
        lblListName.text = categories
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}

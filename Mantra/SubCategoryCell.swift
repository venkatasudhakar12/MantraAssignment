//
//  SubCategoryCell.swift
//  Mantra
//
//  Created by Sudhakar on 10/01/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit

class SubCategoryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var displayNameLabel: UILabel?
    
    var item: SubCategory?  {
        didSet {
            nameLabel?.text = item?.name.capitalized
            displayNameLabel?.text = item?.displayName
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

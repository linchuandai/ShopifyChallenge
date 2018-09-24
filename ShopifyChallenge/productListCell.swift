//
//  productListCell.swift
//  ShopifyChallenge
//
//  Created by Leon Dai on 2018-09-23.
//  Copyright © 2018 Leon Dai. All rights reserved.
//

import UIKit

class productListCell: UITableViewCell {
    
    //var productIDList: [Int] = []
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

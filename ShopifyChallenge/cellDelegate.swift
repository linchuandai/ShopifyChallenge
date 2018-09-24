//
//  cellDelegate.swift
//  ShopifyChallenge
//
//  Created by Leon Dai on 2018-09-18.
//  Copyright © 2018 Leon Dai. All rights reserved.
//

import Foundation

protocol cellDelegate: NSObjectProtocol {
    func tagTapped (productIds: [Int])
}

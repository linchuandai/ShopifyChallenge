//
//  ProductViewController.swift
//  ShopifyChallenge
//
//  Created by Leon Dai on 2018-09-18.
//  Copyright © 2018 Leon Dai. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    private var product_count = 0
    
    var product_data: [[String: Any]] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.isUserInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        product_count = product_data.count
        print (product_count)
        print (product_data)
        
        DispatchQueue.main.async{
            //self.tableview.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table view delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product_count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListCell") as? productListCell ?? productListCell(style: .default, reuseIdentifier: "productListCell")
        
        let product = product_data[indexPath.row]

        let product_name_label = UILabel(frame: (CGRect(x: 20, y: 10, width: 500, height: 30)))
        product_name_label.text = "Product Name: \(product["title"]!)"
        product_name_label.tag = indexPath.row
        cell.contentView.addSubview(product_name_label)
        
        let product_quantity_label = UILabel(frame: (CGRect(x: 20, y: 50, width: 500, height: 30)))
        product_quantity_label.text = "Product Quantity: \(product["inventory_quantity"]!)"
        product_quantity_label.tag = indexPath.row
        cell.contentView.addSubview(product_quantity_label)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }


}

//
//  MainViewController.swift
//  ShopifyChallenge
//
//  Created by Leon Dai on 2018-09-18.
//  Copyright © 2018 Leon Dai. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    private var productData: [[String: Any]] = []
    private var tagData: [String: [[String: Any]]] = [:]
    private var tagKeys: [String] = []
    private var numTags = 0
    private var tappedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableview.delegate = self
        tableview.dataSource = self
        //cellDelegate = ProductViewController as cellDelegate?
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // table view delegate methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numTags
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagListCell") as? tagListCell ?? tagListCell(style: .default, reuseIdentifier: "tagListCell")
        cell.textLabel?.text = tagKeys[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        tappedItem = indexPath.row
        performSegue(withIdentifier: "ProductShowSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productViewController = segue.destination as? ProductViewController {
            productViewController.product_data = tagData[tagKeys[tappedItem]]!
        }
    }

    private func fetchData() {
        guard let url = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6") else {
            print ("failed")
            return
        }
        
        Alamofire.request(url).responseData(completionHandler: { (resData) -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: resData.result.value!, options: [])
                
                guard let dict = json as? [String: Any] else { return }
                guard let productData = dict["products"] as? [[String: Any]] else { return }
                
                self.dealWithData(productData: productData)
            } catch {
                return
            }
        })
        
    }
    
    private func dealWithData (productData: [[String: Any]]) {
        
        for product in productData {
            let tagArray = (product["tags"] as! String).components(separatedBy: ", ")
           
            var productInformation: [String: Any] = [:]
            productInformation["title"] = product["title"] as! String
            
            var inventory_quantity = 0
            let variantArray = product["variants"] as! NSArray
            
            for variant in variantArray {
                inventory_quantity += (variant as! [String: Any])["inventory_quantity"] as! Int
                
                //productInformation["variants"] += inventory_count as! Int
                //productInformation["variants"] += variant["inventory_quantity"]
            }
            productInformation["inventory_quantity"] = inventory_quantity
            
            for tag in tagArray {
                if let _ = self.tagData[tag] {
                    tagData[tag]!.append(productInformation)
                } else {
                    tagData[tag] = [productInformation]
                }
            }
        }
        
        numTags = tagData.count
        tagKeys = Array(tagData.keys)
        tagKeys = tagKeys.sorted { $0 < $1 }
        
        tableview.reloadData()
    
    }
    
    
}


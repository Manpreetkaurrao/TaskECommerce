//
//  ProductDetailViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 17/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailViewController: UIViewController
{
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var lblProductDesc: UILabel!
    @IBOutlet var lblProductPrice: UILabel!
    var received = ""
    var tempValue = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
    var productName = ""
    var productPrice = ""
    var productDesc = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tempValue = received
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
        do
        {
            let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            for  pname in fetchedValues
            {
                productName = ""
                productDesc = ""
                productPrice = ""
                productName.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                productPrice.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                productDesc.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                if strcmp(tempValue, productName) == 0
                {
                    lblProductName.text = productName
                }
            }
        }
        catch
        {
            fatalError("error")
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
         _ = navigationController?.popViewController(animated:true)
    }
}

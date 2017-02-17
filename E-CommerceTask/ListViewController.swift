//
//  ListViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController
{

    @IBOutlet var tableView: UITableView!
    var tempParentIdentity = ""
    var tempCategoryName = ""
    var matchidentity = ""
    var tempIdentity = ""
    var received : String = ""
    var tempvalue : String = ""
    var catergoryNameList : [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
    var flagForSelection = 0
    var productIdentity = ""
    var flagGoToProductDesc = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tempvalue = received
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadtabledata()
    }

    @IBAction func btnBack(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated:true)
    }
    
    func loadtabledata()
    {
        catergoryNameList = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
        do
        {
            let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                catergoryNameList.insert("", at: 0)
            }
            
            else
            {
                catergoryNameList = []
                for  cname in fetchedValues
                {
                    tempParentIdentity = ""
                    tempCategoryName = ""
                    tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    tempParentIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    if strcmp(tempvalue, tempCategoryName) == 0
                    {
                        break
                    }
                }
                for cname in fetchedValues
                {
                    matchidentity = ""
                    tempIdentity = ""
                    matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                    tempIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    if strcmp(matchidentity, tempParentIdentity) == 0
                    {
                        flagForSelection = 1
                        catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                        continue
                    }
                    flagForSelection = 0
                }
                loadProductList()
            }
        }
        catch
        {
            fatalError("Could not fetch")
        }
        self.tableView.reloadData()
    }
    
    func loadProductList()
    {
        if flagForSelection == 0
        {
            print("product list")
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
            do
            {
                let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
                if fetchedValues.count == 0
                {
                    catergoryNameList.insert("", at: 0)
                }
                    
                else
                {
                    catergoryNameList = []
                    for  pname in fetchedValues
                    {
                        productIdentity = ""
                        productIdentity.append(pname.value(forKeyPath: "parentid") as! String? ?? "")
                        if strcmp(productIdentity, tempIdentity) == 0
                        {
                            catergoryNameList.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                        }
                    }
                }
            }
            catch
            {
                fatalError("error")
            }
        }
    }
    func loadsegue()
    {
        if flagGoToProductDesc == 1
        {
            self.performSegue(withIdentifier: "segueProductDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueProductDetail"
        {
            let listvc : ProductDetailViewController = segue.destination as! ProductDetailViewController
            listvc.received = tempvalue
            print("\(listvc.received)")
            print("\(tempvalue)")
        }
    }
    
    func productselected()
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
        do
        {
            let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            for  pname in fetchedValues
            {
                var productName = ""
                productName.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                if strcmp(tempvalue, productName) == 0
                {
                    flagGoToProductDesc = 1
                }
            }
        }
        catch
        {
            fatalError("error")
        }
    }
    
}

//MARK: -> UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return catergoryNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath as IndexPath) as! ListTableViewCell
        cell.categories = catergoryNameList[indexPath.row]
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tempvalue = ""
        tempvalue = catergoryNameList[indexPath.row]
        print("\(tempvalue)")
        loadtabledata()
        loadsegue()
        
    }

}

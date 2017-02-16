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
    var received : String = ""
    var tempvalue : String = ""
    var catergoryNameList : [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
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
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
        do
        {
            let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                print("in if section")
                catergoryNameList.insert("", at: 0)
            }
            
            else
            {
                print("in else section")
                catergoryNameList = []
                print("\(tempvalue)")
                for  cname in fetchedValues
                {
                    tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    tempParentIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    if strcmp(tempvalue, tempCategoryName) == 0
                    {
                        tempCategoryName = ""
                        break
                    }
                    else
                    {
                        tempCategoryName = ""
                        tempParentIdentity = ""
                    }
                }
                for  cname in fetchedValues
                {
                    matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                    if strcmp(matchidentity, tempParentIdentity) == 0
                    {
                        print("hello")
                        catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                        matchidentity = ""
                    }
                    matchidentity = ""
                }
            }
     }
     catch
     {
        fatalError("Could not fetch")
     }
     self.tableView.reloadData()
     
     }
}

//MARK: -> UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("\(catergoryNameList.count)")
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
        loadtabledata()
    }

}

//
//  FirstViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController
{
    @IBOutlet var tableView: UITableView!
    var catergoryNameList : [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
    var currentCellValue = ""
    var tempCategoryName = ""
    var tempIdentity = ""
    var tempParentIdentity = ""
    var matchidentity = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
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
                catergoryNameList.insert("", at: 0)
            }
            else
            {
                catergoryNameList = []
                for  cname in fetchedValues
                {
                    matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "n/a")
                    if strcmp(matchidentity, "0") == 0
                    {
                        catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "n/a")
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
        //loadtabledata()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "listShowingSegue"
        {
            let listvc : ListViewController = segue.destination as! ListViewController
            listvc.received = currentCellValue
            print("\(listvc.received)")
            print("\(currentCellValue)")
        }
    }
    
}

//MARK: -> UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return catergoryNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! homeTableViewCell
        cell.categories = catergoryNameList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        currentCellValue = ""
        currentCellValue = catergoryNameList[indexPath.row]
        self.performSegue(withIdentifier: "listShowingSegue", sender: self)
        //let ListViewController = self.storyboard?.instantiateViewController(withIdentifier: "listViewController") as! ListViewController
        //self.navigationController?.pushViewController(ListViewController, animated: true)
    }
}




/*func loadtabledata()
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
 catergoryNameList.insert("", at: 0)
 }
 else if flagForSelection == 0
 {
 catergoryNameList = []
 for  cname in fetchedValues
 {
 matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "n/a")
 if strcmp(matchidentity, "0") == 0
 {
 catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "n/a")
 matchidentity = ""
 }
 matchidentity = ""
 }
 }
 else if flagForSelection == 1
 {
 catergoryNameList = []
 for  cname in fetchedValues
 {
 tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
 tempParentIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
 if strcmp(currentCellValue, tempCategoryName) == 0
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
 matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "n/a")
 if strcmp(matchidentity, tempParentIdentity) == 0
 {
 catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "n/a")
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
 
 }*/


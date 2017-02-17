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
    @IBOutlet var imageViewMoving: UIImageView!
    @IBOutlet var imageView: UIImageView!
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
        tableView.backgroundView = imageView
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
                    matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                    if strcmp(matchidentity, "0") == 0
                    {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        /*let orgY = self.imageViewMoving.center.y
        self.imageViewMoving.center.y -= view.bounds.height
        UIView.animateWithDuration(0.5, delay: 0.3, options: nil, animations: {
            self.imageViewMoving.center.y = orgY
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.3, options: <#T##UIViewAnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)*/
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
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = .clear
    }
}






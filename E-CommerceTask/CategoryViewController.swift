//
//  CategoryViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController
{
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var txtname: UITextField!
    var categories : [NSManagedObject] = []
    var contentsForPicker : [String] = []
    var temporary : String = ""
    var top = "TopLevel"
    var identity : Int = 0
    var tempCategoryName : String = ""
    var flag = 0
    var tempIdentity : String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        loadpickerview()
    }
    
    func loadpickerview()
    {
        contentsForPicker = []
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
                contentsForPicker.insert("TopLevel", at: 0)
            }
                
            else
            {
                contentsForPicker.insert("TopLevel", at: 0)
                for  cname in fetchedValues
                {
                    contentsForPicker.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                }
            }
        }
        catch
        {
            fatalError("Could not fetch")
        }
        self.pickerView.reloadAllComponents()
    }
    
    func saveDataInCoreData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let list = NSEntityDescription.entity(forEntityName: "Categorylist",in: context)!
        let category = NSManagedObject(entity: list, insertInto: context)
        let text1 = txtname.text ?? ""
        if (strcmp(text1, "") == 0)
        {
            flag = 1
            let alertController = UIAlertController(title: "Failure", message:
                "Category Name is empty", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        if flag == 0
        {
            txtname.text = ""
            category.setValue(text1, forKey: "categoryName")
            if (strcmp(temporary, top) == 0)
            {
                category.setValue("0", forKey: "parentId")
                identity = identity + 1
                category.setValue(String(identity), forKey: "id")
                print("saving as parent id")
                print("\(text1),\(identity)")
            
            }
            else
            {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
                do
                {
                    let fetchedValues = try context.fetch(fetchRequest)
                    for  cname in fetchedValues
                    {
                        tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                        tempIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                        if (strcmp(temporary, tempCategoryName) == 0)
                        {
                            print("saving as child id")
                            category.setValue(tempIdentity, forKey: "parentId")
                            identity = identity + 1
                            category.setValue(String(identity), forKey: "id")
                            print("\(text1),id:\(identity),parentid:\(tempIdentity)")
                            tempCategoryName = ""
                            tempIdentity = ""
                            break
                        }
                        tempCategoryName = ""
                        tempIdentity = ""
                    }
                    do
                    {
                        try context.save()
                        let alertController = UIAlertController(title: "Success", message:
                        "Successfully added category", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Congratulations", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    }
                    catch
                    {
                        fatalError("error in storing data")
                    }
                }
                catch
                {
                    fatalError("error")
                }
            }
        }
    }
    
    @IBAction func addItems(_ sender: UIButton)
    {
        saveDataInCoreData()
    }
}

//MARK: -> UIPickerViewDelegate, UIPickerViewDataSource

extension CategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return contentsForPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
         return contentsForPicker[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        temporary = contentsForPicker[row]
        loadpickerview()
        //self.pickerView.reloadAllComponents()
    }
}





//
//  ProductViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import  CoreData

class ProductViewController: UIViewController
{
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var txtProductName: UITextField!
    @IBOutlet var txtProductPrice: UITextField!
    @IBOutlet var txtProductDesc: UITextField!
    
    var identity = 0
    var productNameList : [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
    var currentCellValue = ""
    var tempCategoryName = ""
    var tempIdentity = ""
    var tempParentIdentity = ""
    var matchidentity = ""
    var contentsForPicker : [String] = []
    var temporary = ""
    var flag = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func btnSave(_ sender: UIButton)
    {
    
    }
    
    func alertmessage()
    {
        flag = 1
        let alertController = UIAlertController(title: "Failure", message:
            "Category Name is empty", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveDataInCoreData()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let list = NSEntityDescription.entity(forEntityName: "Productlist",in: context)!
        let category = NSManagedObject(entity: list, insertInto: context)
        let text1 = txtProductName.text ?? ""
        let text2 = txtProductPrice.text ?? ""
        let text3 = txtProductDesc.text ?? ""
        if text1 == ""
        {
            alertmessage()
        }
        
        else if text2 == ""
        {
            alertmessage()
        }
        else  if text3 == ""
        {
            alertmessage()
        }
        
        else
        {}
        if flag == 0
        {
            txtProductName.text = ""
            txtProductPrice.text = ""
            txtProductDesc.text = ""
            category.setValue(text1, forKey: "productName")
            category.setValue(text2, forKey: "price")
            category.setValue(text3, forKey: "descriptionProduct")
            /*if (strcmp(temporary, top) == 0)
            {
                category.setValue("0", forKey: "parentId")
                identity = identity + 1
                category.setValue(String(identity), forKey: "id")
                print("saving as parent id")
                print("\(text1),\(identity)")
                
            }
            else
            {*/
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
            //}
        }
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
                contentsForPicker.insert("No category for adding product", at: 0)
            }
                
            else
            {
                //contentsForPicker.insert("TopLevel", at: 0)
                for  cname in fetchedValues
                {
                    //tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    tempIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    for cname in fetchedValues
                    {
                        tempParentIdentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                        if tempIdentity == tempParentIdentity
                        {
                            tempParentIdentity = ""
                            tempIdentity = ""
                            break
                        }
                    }
                }
            }
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
        contentsForPicker.append(cname.value(forKeyPath: "categoryName") as! String? ?? "n/a")
        self.pickerView.reloadAllComponents()
    }

    
}
//MARK: -> UIPickerViewDataSource, UIPickerViewDelegate

extension ProductViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsForPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temporary = contentsForPicker[row]
        self.pickerView.reloadAllComponents()
    }
}

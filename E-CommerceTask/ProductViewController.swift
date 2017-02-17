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
    var flagforpicker = 0
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
    
    override func viewWillAppear(_ animated: Bool) {
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
        let context = appDelegate.persistentContainer.viewContext
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
                for  cname in fetchedValues
                {
                    tempIdentity = ""
                    tempIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    print("\(tempIdentity)")
                    for cname in fetchedValues
                    {
                        flagforpicker = 1
                        tempParentIdentity = ""
                        tempParentIdentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                        if tempIdentity == tempParentIdentity
                        {
                            print("condition true")
                            flagforpicker = 0
                            break
                        }
                    }
                    if flagforpicker == 1
                    {
                        for cname in fetchedValues
                        {
                            var id = ""
                            id.append(cname.value(forKeyPath: "id") as! String? ?? "")
                            if tempIdentity == id
                            {
                                contentsForPicker.append(cname.value(forKeyPath: "categoryName") as! String? ?? "n/a")
                                print("\(contentsForPicker)")
                            }
                        }
                    }
                }
            }
        }
        catch
        {
            fatalError("error")
        }
        self.pickerView.reloadAllComponents()
    }

    
    @IBAction func btnSave(_ sender: UIButton)
    {
        saveDataInCoreData()
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
            print("\(text1),\(text2),\(text3)")
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
            do
            {
                let fetchedValues = try context.fetch(fetchRequest)
                for  cname in fetchedValues
                {
                    tempCategoryName = ""
                    tempIdentity = ""
                    tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    tempIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    if (strcmp(temporary, tempCategoryName) == 0)
                    {
                        identity = identity + 1
                        category.setValue(String(identity), forKey: "id")
                        category.setValue(tempIdentity, forKey: "parentid")
                        print("\(identity),\(tempIdentity)")
                    }
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
        return contentsForPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsForPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        temporary = contentsForPicker[row]
        loadpickerview()
        //self.pickerView.reloadAllComponents()
    }
}

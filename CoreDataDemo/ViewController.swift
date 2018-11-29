//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Palanichamy Padmanabhan on 16/08/18.
//  Copyright © 2018 Palanichamy Padmanabhan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    @IBAction func btnInsertClicked(_ sender: UIButton) {
        print("Inserting")
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("Pal", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        newUser.setValue("5", forKey: "age")
        
        do  {
            try context.save()
        }
        catch {
            print("Failed saving")
        }
    }
    @IBAction func btnFetchClicked(_ sender: UIButton) {
        print("Fetching")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        request.returnsObjectsAsFaults = false
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            print(result)

            for data in result as! [NSManagedObject]
            {
                print(data.value(forKey: "username") as! String)
                print(data.value(forKey: "password") as! String)
                print(data.value(forKey: "age") as! String)
                print(data.objectID)

            }
        }
        catch {
            print("Failed fetching")
        }
    }
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        print("Deleting")
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName:"Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch {
            print("There was an error")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


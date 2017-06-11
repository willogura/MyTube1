//
//  CreateAccountViewController.swift
//  MyTube
//
//  Created by William Ogura on 6/4/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit


import Foundation

import CoreData

var globalUsername = "Default"



class CreateAccountViewController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    
    
    
    @IBOutlet weak var greenButton: UIView!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var textOutput: UILabel!
    
    var table : MSSyncTable?
    var store : MSCoreDataStore?
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Users")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
        
        // show only non-completed items
        //  fetchRequest.predicate = NSPredicate(format: "complete != true")
        
        // sort by item text
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        // sort by item text
        
        
        // Note: if storing a lot of data, you should specify a cache for the last parameter
        // for more information, see Apple's documentation: http://go.microsoft.com/fwlink/?LinkId=524591&clcid=0x409
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
       // resultsController.delegate = self;
        
        return resultsController
    }()
    
    
    
    
    
    
    
    
    
    @IBAction func savePressed(_ sender: Any) {
        
        if(usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true) {
            
            self.textOutput.text = "Both Fields Must Have Values"
            
            self.textOutput.isHidden = false
            
            
            
            return
        }
        
        var username = usernameField.text
        
        var password = passwordField.text
        
        let itemToInsert = ["username": username, "password": password]
        
        
        let client = MSClient(applicationURLString: "https://woguramobileapp.azurewebsites.net")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
        self.store = MSCoreDataStore(managedObjectContext: managedObjectContext)
        client.syncContext = MSSyncContext(delegate: nil, dataSource: self.store, callback: nil)
        
        
   
        
        
        var itemTable:MSTable = client.table(withName: "users")
   
        
        itemTable.insert(itemToInsert,
                         completion: {
                            insertedItem, error in
                            if (error != nil){
                                print("error: \(error)")
                            }
                            else{
                                print("Success!")
                                
                                
                                self.textOutput.text = "Account Created Succesfully"
                                
                                self.textOutput.isHidden = false
                                
                                 globalUsername = self.usernameField.text!
                                
                                
                                self.usernameField.text = nil
                                
                                self.passwordField.text = nil
           
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                                   self.performSegue(withIdentifier: "cancel", sender: self)
                                    
                                })
                                
                               
                            }
        }
        )

  
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.layer.cornerRadius = 10.0
        greenButton.layer.cornerRadius = 10.0
        
        
        
        let client = MSClient(applicationURLString: "https://woguramobileapp.azurewebsites.net")
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext!
        self.store = MSCoreDataStore(managedObjectContext: managedObjectContext)
        client.syncContext = MSSyncContext(delegate: nil, dataSource: self.store, callback: nil)
        self.table = client.syncTable(withName: "Users")
       
        
        var error : NSError? = nil
        do {
            try self.fetchedResultController.performFetch()
        } catch let error1 as NSError {
            error = error1
            print("Unresolved error \(error), \(error?.userInfo)")
            abort()
        }
        
        
  
        
       self.table = client.syncTable(withName: "Users")
        
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}



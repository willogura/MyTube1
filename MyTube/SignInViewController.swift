//
//  SignInViewController.swift
//  MyTube
//
//  Created by William Ogura on 6/4/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInView: UIView!
    
    @IBAction func usernameStarted(_ sender: Any) {
        
        
        self.textOutput.isHidden = true
    }
    
    
    @IBAction func passwordStarted(_ sender: Any) {
        
        
        self.textOutput.isHidden = true
        
        
    }
    
    
    @IBOutlet weak var greenButton: UIView!
    
    
    @IBOutlet weak var textOutput: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        globalUsername = "Default"
        
        
        self.textOutput.text = "Signed-Out"
        
        self.textOutput.isHidden = false
        
        
        
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
        
        
        self.table!.pull(with: self.table?.query(), queryId: "AllRecords") {
            (error) -> Void in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if error != nil {
                // A real application would handle various errors like network conditions,
                // server conflicts, etc via the MSSyncContextDelegate
                print("Error: \((error! as NSError).description)")
                
                // We will just discard our changes and keep the servers copy for simplicity
                if let opErrors = (error! as NSError).userInfo[MSErrorPushResultKey] as? Array<MSTableOperationError> {
                    for opError in opErrors {
                        print("Attempted operation to item \(opError.itemId)")
                        if (opError.operation == MSTableOperationTypes() || opError.operation == .delete) {
                            print("Insert/Delete, failed discarding changes")
                            opError.cancelOperationAndDiscardItem(completion: nil)
                        } else {
                            print("Update failed, reverting to server's copy")
                            opError.cancelOperationAndUpdateItem(opError.serverItem!, completion: nil)
                        }
                    }
                }
            }
        }
        
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInPressed(_ sender: Any) {
        
        if(usernameField.text?.isEmpty == true || passwordField.text?.isEmpty == true) {
            
            self.textOutput.text = "Both Fields Must Have Values"
            
            self.textOutput.isHidden = false
            
            
            
        }
        
        var username = usernameField.text
        
        var password = passwordField.text
        


        
      var results =   self.fetchedResultController.fetchedObjects
        
     var count = 0
        
        count = (results?.count)! - 1
        
        while (count >= 0) {

                 var item =  results?[count] as! NSManagedObject

            print( item.value(forKey: "username"))
            
            var user = item.value(forKey: "username") as! String
            
            if(user  == self.usernameField.text) {

                print("username matches")

            var pass = item.value(forKey: "password") as! String
    
                if(pass == self.passwordField.text) {

                    print("username and password matches!!")
                    
    
                    globalUsername = user
                    
                    self.textOutput.text = "Signed-In"
                    
                    self.textOutput.isHidden = false
                    
                    break
   
                }

            }
            
            count = count - 1
            
            if(count < 0) {
                
                
                self.textOutput.text = "No Account Found"
                
                self.textOutput.isHidden = false
                

                
            }
        }
        
    
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  MainTableViewController.swift
//  HalfTunes
//
//  Created by William Ogura on 10/25/16.
//
//

import UIKit


var category = Category(categoryFactory: CategoryFactory(factorySettings: home()))

var featuredCategory = Category(categoryFactory: CategoryFactory(factorySettings: home()))

var suggestedSearch : Section?



var search = VideoSearch()

var updater = Updater()


class MainTableViewController: UITableViewController {
    
    var parentCategory = featuredCategory
    
    @IBOutlet weak var slideShowView: UIView!
    
    @IBOutlet weak var mainTableView: UIView!
    
    @IBOutlet var tableView1: UITableView!
    
  
    
    
    convenience init() {
        
        self.init()
        
        category = self.parentCategory
        
    }
    
    
    
  
    
    
    
    
    func setCategory(newCategory: Category) {
        
        
        if(newCategory.categoryTitle == featuredCategory.categoryTitle) {
            
            
            self.parentCategory = featuredCategory
            
            category = self.parentCategory
            
            
        } else {
            
            self.parentCategory = newCategory
            
            category = self.parentCategory
            
        }
        
      
        
    }
    
    
   
    
  
    
    
    func refresh(sender:AnyObject) {
        
        print("refresh called")
        DispatchQueue.global(qos: .background).async {
            
            DispatchQueue.main.async( execute: {
                
                self.embeddedViewController?.refreshTable()
                
    
                
            })
            
            self.refreshControl?.endRefreshing()
            
        }
        
    }
    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        
    
       NotificationCenter.default.addObserver(self, selector: #selector(self.loadVideos), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
       
        
    }
    
    func loadVideos() {
        
        DispatchQueue.global(qos: .background).async {
            
            
            
 
            
         self.embeddedViewController?.preloadThumbnails()
            
      
            
            
        }

        
      
    }
    
    
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
     UIApplication.shared.isStatusBarHidden = false
        
        
        category = self.parentCategory
        
        self.title = self.parentCategory.categoryTitle
        
        
    }
    
    
    func categoryPressed() {
        
        self.performSegue(withIdentifier: "categoryPressed", sender: self)
        
    }
    
    func changeSize(height: Int) {
        
        mainTableView.frame.size.height = CGFloat(height)
        
        self.tableView1.layoutMarginsDidChange()
        
        self.tableView1.reloadData()
        
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    var embeddedViewController: HorizontalTableViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "embedSegue") {
            
            self.embeddedViewController = segue.destination as? HorizontalTableViewController
            
        }
        
     

    }

}

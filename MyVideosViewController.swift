

import Foundation

import UIKit


import MediaPlayer

import AVKit





var myVideos = [Video]()



class MyVideosViewController: UITableViewController{
    
    var videos = [Video]()
    

    
    var myVideoEmptyLabel : UILabel?
    
  
    
    // var moviePlayer : MPMoviePlayerController?

 
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(loadVideos() != nil) {
            
            
            myVideos = loadVideos()!
            
        }
       
        //  self.filtered = self.myVideos
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
        //    self.tableView.reloadData()
        
        
        
        if(loadVideos() != nil) {
            
            
            // myVideos = loadVideos()!
            
        }
     
        // super.viewWillAppear(animated)
        tableView.reloadData()
        
        
      
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.shouldRotate = false // or false to disable rotation
    }
    
    
    
 
    override func awakeFromNib() {
        tableView.reloadData()
        
    }
    
    
    
    func playVideo(_ video: Video) {
        
     
       
            
            if let urlString = video.sourceUrl {
                print("url string \(urlString)")
                
                let fileUrl = URL(string: urlString)
                
          
           
                let asset = AVAsset(url: fileUrl!)
                
                let playerItem = AVPlayerItem(asset: asset)
                
                let fullScreenPlayer = AVPlayer(playerItem: playerItem)
                
                fullScreenPlayer.play()
                
                let fullScreenPlayerViewController = AVPlayerViewController()
                
                fullScreenPlayerViewController.player = fullScreenPlayer
                
                present(fullScreenPlayerViewController, animated: true, completion: nil)
                
     
                
            }
            
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        let cellIdentifier = "VideoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VideoCell
        
        
        
        // Fetches the appropriate video for the data source layout.
        
        let video : Video?
        
        video = myVideos[(indexPath as NSIndexPath).row]
        
        
      
        
        cell.titleLabel.text = video!.title
        
      
        
        cell.thumbnailView.image = video!.thumbnail
        
        
        cell.thumbnailView.setRadius(radius: imageRadius)
        
   
        
        return cell
        
    }
    
    
    
    
    
    

    
  
    
    func thumbnailTapped(_ cell: VideoCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            
            let video = myVideos[(indexPath as NSIndexPath).row]
            
            
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            
            playVideo(video)
            
        }
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            
            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
            
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                
                
                
                let videoDetailViewController = segue.destination as! VideoViewController
                
                // Get the cell that generated this segue.
                
                if let selectedVideoCell = sender as? VideoCell {
                    
                    let indexPath = self.tableView.indexPath(for: selectedVideoCell)!
                    
                    
                    let selectedVideo = myVideos[indexPath.row]
                    
                    videoDetailViewController.video = selectedVideo
                    
      
                        let sections = Category(categoryFactory: CategoryFactory(factorySettings: home()))
                        
                        
                        sections.createListing()
                        
                        
                        videoDetailViewController.setCategory(category: sections)
     
                    
           
                    
                }
                
                
                
                
                DispatchQueue.main.async( execute: {
                    
                    LoadingOverlay.shared.hideOverlayView()
                })
            }
            
        }
        
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    // Override to support conditional editing of the table view.
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        
        return myVideos.count   //use data.count to always display intial table of all searchResults
        
    }
    
    // Override to support editing the table view.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
     
            
            myVideos.remove(at: indexPath.row)
            
            
     
            
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
       
            
            saveVideos()
            
         
            
        } else if editingStyle == .insert {
            
            
            print("insert runs")
            
      
        }
        
    }
    

    
    @IBAction  func unwindToVideoList(_ sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? VideoViewController, let video = sourceViewController.video {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing video.
                
                print("updating from unwind")
                
                //  videos[selectedIndexPath.row] = video
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add a new video.
                
                
                if(!myVideos.contains(video)) {
                    let newIndexPath = IndexPath(row: myVideos.count, section: 0)
                    
                    
                    
                    //filtered.append(video)
                    myVideos.append(video)
                    
                    self.tableView.insertRows(at: [newIndexPath], with: .bottom)
                    
                    
                    
                }
            }
            // Save the videos.
 
            saveVideos()
            
            
            
        }
        
    }
    
    // MARK: NSCoding
    
    func saveVideos() {
        
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
        
        
        
        
        if !isSuccessfulSave {
            
            print("Failed to save videos...")
            
        }
        
    }
    
    func loadVideos() -> [Video]? {
        
        let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
        
        return  loaded
        
    }
    
    
    
 
 

  
    

}







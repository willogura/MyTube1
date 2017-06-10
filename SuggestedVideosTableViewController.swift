

import UIKit

class SuggestedVideosTableViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
   
    
    @IBOutlet weak var addVideoButton: UIButton!
    

    @IBOutlet var suggestedVideoTable: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
  
    var myVideos = [Video]()
    
    var section: Int?
    
    var recommendedVideos = [Video]()
    
    var video: Video?
    
    var parentView : VideoViewController!
    
    var currentCategory: Category?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    func setCategory(category: Category) {
        
        currentCategory = category
        
    }
    
    func setCategory(category: Category, section: Int) {
        
        currentCategory = category
        
        self.section = section
        
    }
    
    
    
    
    func setVideo(video: Video) {
        
      //self.titleLabel.text = video.title
        
        
        
        
            
            if(self.section == nil) {
                
         
                recommendedVideos =  search.getYouTubeVideos(playlist: (currentCategory?.sections[0].sectionPlaylist!)!)!
                
                recommendedVideos = search.trimVideos(videoArray: recommendedVideos, numberToReturn: 10)
                
            } else {
                
          
                
                recommendedVideos =  search.getYouTubeVideos(playlist: category.sections[self.section!].sectionPlaylist!)!
                
                recommendedVideos = search.trimVideos(videoArray: recommendedVideos, numberToReturn: 10)
                
            }
            
        
        myVideos = recommendedVideos
        
        self.video = video
        
        if( removeDuplicateVideo(video: video, videoList: recommendedVideos) ) {
            
            tableView.reloadData()
        }
        
        
        
        
        
    }
    
    
    func removeDuplicateVideo(video: Video, videoList: [Video]) -> Bool {
        
        var videoList = videoList
        
        var count = 0
        
        for vid in videoList {
            
            if(video.title == vid.title) {
                
                videoList.remove(at: count)
                
                self.recommendedVideos = videoList
                
                self.myVideos  = videoList
                
                return true
            }
            
            count += 1
            
        }
        
        return false
    }
    
    

    
    



    
    @IBAction func addVideoPressed(_ sender: AnyObject) {
        
        parentView.addVideo(self.addVideoButton)
        
    }
    
   
    
}

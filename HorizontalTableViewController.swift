


import UIKit


var selectedSection = 1
var currentVideo: Video? = nil

class HorizontalTableViewController: UITableViewController {
    
    var listOfVideos = [Int: [Video]]()
    
    var search = VideoSearch()
    
    var currentCategory: Category?
    
    var featuredVideos: [[Video?]]  = [[Video?]]()
    
    var videos : [[Video?]]  = [[Video?]]()
    
    var defaultDisplayCount = 15
    
    var sectionTitles = [String]()

    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        print("memoery warning recevied and caches cleared")
        
        URLCache.shared.removeAllCachedResponses()
        
        
        imageCache.removeAllObjects()
        
    }
    
    @IBOutlet weak var tableCollection: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
     
            
            saveFeaturedVideos()
            
        
        
        self.updateTable()
        
        
        
    }
    
    
    
    func preloadThumbnails() {

        var videos = [Video]()

        DispatchQueue.global(qos: .background).async {
            
            var count = 0
            
            var index = 0
            
            
            while (category.sections.count > count) {
                
                if(category.sections[count].sectionType == SectionType.videoList   ) {
        
                        videos =  self.search.getYouTubeVideos(playlist: category.sections[count].sectionPlaylist!)!
     
                        while (videos.count > index && index < 20) {
           
                                if( videos[index].hasThumbnailUrl()) {
                                    
                                    self.search.getThumbnail(url: (videos[index].thumbnailUrl)!)
                                    
                                    
                                }
      
                            index = index + 1
                        }
                        
                        index = 0

                }

                count = count + 1
                
            }

        }

    }
    
    public func updateTable() {
        
        if(self.currentCategory?.categoryTitle != category.categoryTitle ) {
            
            
            if(category.categoryTitle == featuredCategory.categoryTitle && self.featuredVideos.count > 5 ) {
                
                
                self.currentCategory = category
                
                self.loadFeaturedVideos()
                
                self.tableView.reloadData()
                
                self.changeTableSize()
                
            } else  {
                
                self.currentCategory = category
                
                self.videos.removeAll()
                
                if(category.sections.count == 0) {
                    
                    category.createListing()
                    
                }
                self.currentCategory = category
                
                if(self.videos.count == 0) {
                    
                    DispatchQueue.main.async{
                        
                        LoadingOverlay.shared.showOverlay(view: self.parent?.view)
                        
                    }
                    
                    DispatchQueue.global(qos: .background).async {
                        
                        var index = 0
                        
                        while (index < category.sections.count) {
                            
                            if(category.sections[index].searchID != nil) {
                                
                             
                                        
                                        if(category.sections[index].getDisplayCount() == nil) {
                                            
                                            
                                            self.videos.append(self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)!)
                                            
                                            
                                        } else {
                                            
                                            
                                            let vids = self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)
                                            
                                            print("playlist \(category.sections[index].sectionPlaylist!) ")
                                            
                                            let trimmedVids = self.search.trimVideos(videoArray: vids!, numberToReturn: category.sections[index].getDisplayCount()!)
                                            
                                            self.videos.append(trimmedVids)
                                            
                                        }
                                
                          
                                        
                                        
                                
                                
                            } else {
                                
                                self.videos.append([nil])
                                
                            }
                            
                            index = index + 1
                            
                        }
                        
                        if(self.videos.first?.first != nil) {
                            
                            currentVideo = (self.videos.first?.first)!
                            
                            print("CURRENT VIDEIO LOADS \(currentVideo?.title)")
                            
                            
                            var mainTable = self.parent as! MainTableViewController
                            
                            mainTable.loadInitialVideo()
                            
                            
                        }
                        
                        
                        DispatchQueue.main.async{
                            
                            self.tableView.reloadData()
                            
                            LoadingOverlay.shared.hideOverlayView()
                            
                        }
                        
                    }
                    
                    self.changeTableSize()
               
                        self.saveFeaturedVideos()
                        
                    
                    
                    
                    
                }
                
            }
            self.preloadThumbnails()
        }
     
        
        
    }
    
    override func viewDidLoad() {
        
   
        
    }
    
    
    public func refreshTable() {
        
        self.videos = [[Video?]]()
        
        DispatchQueue.main.async{
            
            LoadingOverlay.shared.showOverlay(view: self.parent?.view)
            
            var index = 0
            
            while (index < category.sections.count) {
                
                if(category.sections[index].searchID != nil) {
                  
                        
                        if(category.sections[index].getDisplayCount() == nil) {
                            
                            self.videos.append(self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)!)
                            
                        } else {
                            
                            let vids = self.search.getYouTubeVideos(playlist: category.sections[index].sectionPlaylist!)
                            
                            let trimmedVids = self.search.trimVideos(videoArray: vids!, numberToReturn: category.sections[index].getDisplayCount()!)
                            
                            self.videos.append(trimmedVids)
                            
                        }
                        
                    
                    
                    
                } else {
                    
                    self.videos.append([nil])
                    
                }
                
                index = index + 1
                
            }
            
            self.tableView.reloadData()
            
            
            
            LoadingOverlay.shared.hideOverlayView()
            
            
            self.preloadThumbnails()
            
        }
        
        
        self.changeTableSize()
        
    
            self.saveFeaturedVideos()
            
     
        
        
        
        
        
    }
    
    
    func saveFeaturedVideos() {
        
        
        print("save called")
        featuredVideos = videos
        
    }
    
    func loadFeaturedVideos() {
        
        print("load called")
        videos = featuredVideos
        
    }
    
    func changeTableSize() {
        
        var tableSize: CGFloat = 0
        
        for section in (currentCategory?.sections)! {
            
           
                
                tableSize = tableSize + CGFloat(165)
                
                
         
            
        }
        
        
        let parentVC = self.parent as! MainTableViewController
        
        parentVC.changeSize(height: Int(tableSize))
        
        self.tableView.frame.size.height = tableSize
        
        self.tableView.reloadData()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if(videos.count == 0) {
            
            return 0
            
        } else {
            
            return category.sections.count
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> HorizontalTableViewCell {
        
        let section = category.getSection(row: indexPath.section)

        
            self.tableView.rowHeight = 165.0
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? HorizontalTableViewCell
            
            cell!.sectionLabel.text = section.sectionTitle
            
            if(section.displayCount == nil){
                
                section.displayCount = 15
                
            }
            
  
        return cell!
        
    }
    
 
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? HorizontalTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, self, forRow: indexPath.section)
        
        tableViewCell.reloadCell()
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  
        
        guard cell is HorizontalTableViewCell else { return }
        
    }
    
    
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            if let collectionCell: HorizontalCollectionViewCell = sender as? HorizontalCollectionViewCell {
                
                if let collectionView: UICollectionView = collectionCell.superview as? UICollectionView {
                    
                    if let destination = segue.destination as? VideoViewController {
                        
                        DispatchQueue.main.async(){
                            
                            LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
                            
                        }
                        
                        let indexPath = collectionView.indexPath(for: collectionCell)!
                        
                        suggestedSearch = category.sections[collectionView.tag]
                        
                        let selectedVideo = self.videos[collectionView.tag][indexPath.row]
                        
                        destination.video = selectedVideo
                        
                        selectedSection = collectionView.tag
                        
                    
                        
                    }
                    
                }
                
            }
            
        }
        
        

        
    }
    
}


extension HorizontalTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(category.sections[safe: collectionView.tag]?.sectionType == SectionType.videoList ) {
            
            
       
            
            
            if let count = videos[safe: collectionView.tag]?.count {
                
                
                
                
                return count
                
            }
            
            self.refreshTable()
            
            
            return 0
            
            
            
            
            
            
        }
        
        print("should not get here")
        return videos[collectionView.tag].count
        
    }
    
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        
       
            
         var video = videos[collectionView.tag][indexPath.item]
        
        
        print("Video Selected from horizontal collection view\(video?.title)")
        
        
        //set the global variable currentVideo to the selected video
        
        currentVideo = video
        
        
        var parent = self.parent as! MainTableViewController
        
        //get the parent mainTable and loadInitialVideo which loads the currentVideo
        
        parent.loadInitialVideo()
        
        
            }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionCell", for: indexPath)
        
        var cells : HorizontalCollectionViewCell
        
        cells = cell as! HorizontalCollectionViewCell

        if(category.sections[safe: collectionView.tag]?.sectionType == SectionType.videoList   ) {
            
            
            
            var videos = [Video]()
            
       
                
                
                videos =  search.getYouTubeVideos(playlist: category.sections[collectionView.tag].sectionPlaylist!)!
                

            if (videos[safe: indexPath.item]?.fileName != nil) {
                
              
              
           
                    
                    cells.thumbnail.image = self.search.getThumbnail(url: (videos[indexPath.item].thumbnailUrl)!)
                    
              
                    
                
                
                
                cells.thumbnail.setRadius(radius: imageRadius)
                
                
                cells.titleLabel.text = videos[indexPath.item].title
                
                
                
                
              
                
            } else  {
               
                if( videos[safe: indexPath.item] != nil) {
                    
                cells.thumbnail.image = #imageLiteral(resourceName: "placeholder-header")
                
                cells.thumbnail.setRadius(radius: imageRadius)
                
                
                cells.titleLabel.text = videos[safe: indexPath.item]?.title
              
                } else {
                    
                    
                    cells.titleLabel.text = nil
                    
                   
                    
                }
            }
        }
        
        return cell
        
    }
    
 
    
}

















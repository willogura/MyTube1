
import Foundation

import MediaPlayer

import UIKit

import AVFoundation

import AVKit

class VideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var childView: SuggestedVideosTableViewController {
        
        get {
            
            let ctrl = childViewControllers.first(where: { $0 is SuggestedVideosTableViewController })
            
            return ctrl as! SuggestedVideosTableViewController
        }
        
    }
    
    @IBOutlet weak var child: UIView!
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var thumbnailButton: UIButton!
    
    let playerViewController = VideoPlayer()
    
    var moviePlayer : AVPlayer?
    
    var video: Video?
    
    var videoLoaded: Bool = false
    
    var currentCategory: Category?
    
    var webView: UIWebView?
    
  
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func hidePlayer() {
        
        self.thumbnailButton.isHidden = true
        
    }
    
    func showPlayer() {
        
        self.thumbnailButton.isHidden = false
        
    }
    
    
    func setCategory(category: Category) {
        
        self.currentCategory = category
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    
        
        self.thumbnailButton.isHidden = true
        
        playerViewController.player?.pause()
        
        webView? = UIWebView()
        
    }
    

  
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.shouldRotate = false// or false to disable rotation
        
        if(videoLoaded == false) {
            
            showPlayer()
            
        }
        
   
        
    }
    
    func loadVideoThumbnail(video: Video) {
        
        DispatchQueue.global(qos: .background).async {
            
       
            
            self.thumbnailView.image = video.thumbnail
            
            if(   self.thumbnailView.image == nil &&  video.fileName != 1) {
                
                video.generateThumbnail()
                
                self.thumbnailView.image = video.thumbnail
                
            } else if (self.thumbnailView.image == nil  && video.fileName == 1) {
                
                if(video.hasThumbnailUrl()) {
                    
                    video.thumbnail = search.getThumbnail(url: video.thumbnailUrl!)
                    
                    self.thumbnailView.image = video.thumbnail
                    
                }
                
            }
            
            DispatchQueue.main.async(){
                
                LoadingOverlay.shared.hideOverlayView()
                
            }
            
        }
        
    }
    
    
 
    
    
    func loadVideoDescription(video: Video) {
        
      
        self.navigationItem.title = video.title
        
        self.childView.titleLabel.text   = video.title
        
        self.childView.descriptionLabel.text = video.comments
        
        self.video = video
        
        self.childView.parentView = self
        
        self.childView.setVideo(video: video)
        
    }
    
    

    
    
    override func viewDidLoad() {
        
     
        showPlayer()
        
        self.childView.addVideoButton.setTitle("Save in Library", for: UIControlState.selected)
        
        super.viewDidLoad()
        
     
        
        if(self.currentCategory != nil) {
            
            self.childView.setCategory(category: self.currentCategory!)
            
        } else {
            
            self.currentCategory = category
            
            self.childView.setCategory(category: self.currentCategory!, section: selectedSection)
            
        }
        
        if(self.video == nil){
            
            print("The video did not load into Video View Controller")
            
            self.navigationController?.popViewController(animated: true)
        }
        
        /*
        while(self.video == nil) {   //probably should not use an infinite loop. If the video detail view stalls this is likely why
            
            var i = 0
            
            i = i + i
            
        }
 
 */
        
        if let video = self.video {
            
          
                
                loadVideoDescription(video: video)
                
                loadVideoThumbnail(video: video)
                
                showPlayer()
                
            
            
        }
        
        if(self.loadVideos() != nil) {
            
            
            myVideos = self.loadVideos()!
            
        }
        
        if (self.hasSavedVideo()) {
            
            
            self.toggleAddButton()
        }
        
        self.thumbnailButton.isHidden = false
        
    }
    
 
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
     
        
        if(loadVideos() != nil) {
            
            myVideos = loadVideos()!
            
        }
        
        toggleAddButton()
        
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
        
    }
    
    
    
    func loadVideos() -> [Video]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Video.ArchiveURL.path) as? [Video]
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        

        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        
        let isPresentingInAddVideoMode = presentingViewController is UINavigationController
        
        if isPresentingInAddVideoMode {
            
        
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
    
            navigationController!.popViewController(animated: true)
            
        }
        
    }
    
    
    func addVideo(_ sender: AnyObject) {
        
        if(childView.addVideoButton.titleLabel?.text == "+ Love It"){
            if(!childView.addVideoButton.isSelected) {
                saveVideos()
            }
        }
        
     
        
    
        
    }
    
    func hasSavedVideo() -> Bool {
        
        for vid in myVideos {
            
            if (vid.title == video?.title) {
                
                return true
            }
        }
        
        return false
    }
    
    func saveVideos() {
        
        
        myVideos.append(video!)
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(myVideos, toFile: Video.ArchiveURL.path)
        
        
        if (isSuccessfulSave) {
            
            toggleAddButton()
        } else {
            
            print("Failed to save videos...")
            
        }
        
    }
    
    
    
    @IBAction func playVideo(_ sender: AnyObject) {
        
        self.thumbnailButton.isHidden = true
        
        self.videoLoaded = true
        

            
            webView = UIWebView(frame: self.thumbnailView.frame)
            
            self.view.addSubview(webView!)
            
            self.view.bringSubview(toFront: webView!)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
            webView?.allowsInlineMediaPlayback = true
            
            webView?.mediaPlaybackRequiresUserAction = false
            
            var videoID = ""
            
            videoID = (video?.sourceUrl)!     // https://www.youtube.com/watch?v=28myxjncnDM     http://www.youtube.com/embed/28myxjncnDM
            
            let embededHTML = "<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(self.thumbnailView.frame.size.width)' height='\(self.thumbnailView.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
            
            webView?.loadHTMLString(embededHTML, baseURL: Bundle.main.resourceURL)
            
        
    }
    

 
    
    
    func toggleAddButton() {
        
        if(video != nil) {
            
          
                
                if(hasSavedVideo()) {
                    
                    if(currentCategory?.videoType != VideoType.youtube  ) {
                        
                        childView.addVideoButton.setTitle("Save in Library", for: UIControlState.selected)
                        
                    } else {
                        
                        childView.addVideoButton.setTitle("Loved It", for: UIControlState.selected)
                        
                    }
                    
                    childView.addVideoButton.isSelected = true
                    
                } else {
                    
                    childView.addVideoButton.setTitle("+ Love It", for: UIControlState.normal)
                    
                    childView.addVideoButton.isSelected = false
                }
                
            
            
        }
    }
    
    
    
  
    
}



class VideoPlayer: AVPlayerViewController {
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        if view.bounds == contentOverlayView?.bounds {
            
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = false
            
            UIApplication.shared.isStatusBarHidden = false
            
        } else {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            appDelegate.shouldRotate = true // or false to disable rotation
            
             UIApplication.shared.isStatusBarHidden = false
            
        }
    }
    
}

















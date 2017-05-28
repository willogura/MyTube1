

import Foundation
import UIKit





class VideoSearch : UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    fileprivate var searchResults = [Video]()
    
    fileprivate var thumbnailResults = [Thumbnail]()
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
 
    
    /// Creates the NSURL session necessary to download content from remote URL.
    
    fileprivate func getNSURLSession() -> URLSession {
        
        //   let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        //  session.configuration.urlCache?.removeAllCachedResponses()
        
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return defaultSession
        
    }
    
    
    
    
 

    
    
    func getYouTubeVideos(playlist: String) -> [Video]? {
        
        //  var playlistID = "PLc4OSwdRXG_KJwyC0WFroPmqwA67PAhZI"
        
        
        let playlistID = playlist
        
        
        
        
        let apiKey = "AIzaSyAXDqPJiyrh1QW2X_-Dy_KUWxIez9E2FHU"
        
        
        let maxResults = 50
        
        
        //this gives all videos within a specifed playlist
        
       
        let urlString = URL( string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistID)&key=\(apiKey)&maxResults=\(maxResults)")

        
  //gives recent uploads id for channel  https://www.googleapis.com/youtube/v3/channels?part=contentDetails&forUsername=CTVnorthsuburbs&key=AIzaSyAXDqPJiyrh1QW2X_-Dy_KUWxIez9E2FHU
        
        
        
        //this gives all playlists with id for given channel
        
        //   let urlString = URL( string: "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=UCItaxOh-FCAiD2Hjqt1KlEw&key=AIzaSyAXDqPJiyrh1QW2X_-Dy_KUWxIez9E2FHU&maxResults=\(maxResults)")
        
        
        
        
        //   let urlString = URL( string: "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,snippet&forUsername=ctvteens&key=AIzaSyAXDqPJiyrh1QW2X_-Dy_KUWxIez9E2FHU" )
        
        // Create a NSURL object based on the above string.
        //   let searchURL = NSURL(string: urlString)
        
        // Fetch the playlist from Google.
        
        
        let session = getNSURLSession()
        
        // let searchURL = URL(string: "http://trms.ctv15.org/Cablecastapi/v1/shows/?idinclude=vod,thumbnail")
        
        
        let video =   self.getYoutubePlaylists(session, url: urlString! as URL)
        
        
        
        return video
        
    }

    
    fileprivate func getYoutubePlaylists(_ defaultSession: URLSession, url: URL) -> [Video]? {
        
        let semaphore = DispatchSemaphore(value: 0)
        var video: Video?
        
        
        var videoResults = [Video]()
        
        var dataTask: URLSessionDataTask?
        
       
        
       
        
        if dataTask != nil {
            
            dataTask?.cancel()
            
        }
        
      
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: {
            
            data, response, error in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
            }
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    var json: [String: AnyObject]!
                    
                    
                    do {
                        
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                        
                        //  print(json)
                        
                        
                        
                        guard let results = YoutubeVideo(json: json) else {
                            
                            return
                        }
                        
                        
                        for result in results.items! {
                            
                            
                            
                            
                            
                            guard let snippet = YoutubeItems(json: result as! JSON) else {
                                
                                
                                print("no itmes")
                                
                                
                                return
                            }
                            
                            
                            
                            
                            let videoSnippet = snippet.snippet
                            
                            let title = videoSnippet?.title
                            
                            var thumbnail: String?
                            
                            if(videoSnippet?.thumbnail?.defaultThumbnail?.url != nil) {
                                
                                thumbnail = (videoSnippet?.thumbnail?.defaultThumbnail?.url)!
                                
                                
                            } else {
                                
                                
                                
                                thumbnail = nil
                                
                            }
                            
                            let description = videoSnippet?.description
                            
                          
                            
                            var videoId = "0"
                            
                            if(videoSnippet?.resourceId?.videoId != nil) {
                            videoId  = (videoSnippet?.resourceId?.videoId)!
                            }
                            //   var id = "https://www.youtube.com/watch?v=\(videoId)"
                            
                            
                            var id = "0"
                            
                            id =   videoId
       
                            if(thumbnail != nil) {
                                video = Video(title: title!, thumbnail: nil, fileName: 1, sourceUrl: id, comments: description!, thumbnailUrl: NSURL(string: thumbnail!), id: 1)
                                
                                
                                
                                videoResults.append(video!)
                                
                            } 

                            
                        }
   
                        
                    } catch {
                        
                        print(error)
                        
                    }
                    
                    
                }
                
            }
            semaphore.signal()
        })
        
        dataTask?.resume()
        
        semaphore.wait(timeout: .distantFuture)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        
        
        
        
        
        return videoResults
        
        
    }
    

    
    func trimVideos(videoArray: [Video], numberToReturn: Int) -> [Video] {
        
        
        var reducedResults = [Video]()
        
        var count = numberToReturn
        
        for result in videoArray {
            
            
            if (count > 0) {
                reducedResults.append(result)
            }
            
            count = count - 1
            
            
        }
        
        return reducedResults
        
    }
    

    
    fileprivate func getThumbnailResults(_ defaultSession: URLSession, url: URL) -> String? {
        
        
        let semaphore = DispatchSemaphore(value: 0)
        
        
        var dataTask: URLSessionDataTask?
        
        var thumbnail : String?
        
        if dataTask != nil {
            
            dataTask?.cancel()
            
        }
        
        
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            
            data, response, error in
            
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
            }
            
            if let error = error {
                
                print(error.localizedDescription)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    
                    
                    var json: [String: AnyObject]!
                    
                    
                    do {
                        
                        json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                        
                        
                        
                    } catch {
                        
                        print(error)
                        
                    }
                    
                    
                    
                    guard let results = Thumbnail(json: json) else {
                        
                        return
                    }
                    
                    guard let result = results.thumbnail else {
                        
                        return
                    }
                    
                    
                    thumbnail = result.url
                    
                    
                    
                    
                }
                
            }
            semaphore.signal()
            
        })
        
        
        
        
        dataTask?.resume()
        
        semaphore.wait(timeout: .distantFuture)
        
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        return thumbnail
        
    }
    
    
    

    
    public  func getThumbnail(url: NSURL)-> UIImage? {
        
        
        
        
        var image : UIImage?
        
        
        
        
        
        image = returnImageUsingCacheWithURLString(url: url)
        
   
        
        return(image)
        
        
        
    }
    
    
    public func generateThumbnailUrl(id: Int) -> NSURL? {
        
        
        var thumbnailUrl : String?
        
        var url : NSURL?
        
        

        
        let escapedString = thumbnailUrl!.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        
        
        url = NSURL(string: escapedString! )
        
        
        return url
        
        
    }
    
    
    
}

extension Array {
    
    func chunked(by distance: Int) -> [[Element]] {
        if self.count <= distance {
            return [self]
        } else {
            let head = [Array(self[0 ..< distance])]
            let tail = Array(self[distance ..< self.count])
            return head + tail.chunked(by: distance)
        }
    }
    
}

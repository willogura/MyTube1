

import Foundation


public struct YoutubeVideo: Decodable {
    
    public let items: [NSDictionary]?
    
    public init?(json: JSON) {
        
        guard let items:  [NSDictionary]? = "items" <~~ json
            
            else {
                
                print("JSON youtubeItems doesnt execute")
                
                return nil }
        
        self.items = items
        
    }
    
}


public struct YoutubeItems: Decodable {
    
    let id: String?
    
    let snippet: YoutubeSnippet?
    
    public init?(json: JSON) {
        self.id = "id" <~~ json
        
        self.snippet = "snippet" <~~ json
        
    }
    
}


public struct YoutubeThumbnail: Decodable {
    
    let defaultThumbnail: YoutubeDefaultThumbnail?
    
    public init?(json: JSON) {
        self.defaultThumbnail = "standard" <~~ json
        
        
        
    }
    
}

public struct YoutubeDefaultThumbnail: Decodable {
    
    let url: String?
    
    public init?(json: JSON) {
        self.url = "url" <~~ json
        
        
    }
    
}

public struct YoutubeResource: Decodable {
    
    let videoId: String?
    
    public init?(json: JSON) {
        self.videoId = "videoId" <~~ json
        
        
    }
    
}



public struct YoutubeSnippet: Decodable {
    
    
    public let title: String?
    
    public let description: String?
    
    public let thumbnail: YoutubeThumbnail?
    
    public let channelId: String?
    
   
    
    public let resourceId: YoutubeResource?
    
    public init?(json: JSON) {
        
        
        
        guard let title: String = "title" <~~ json
            
            else {
                
                print("title doesnt work")
                
                return nil }
        
        guard let description: String = "description" <~~ json
            
            else {
                
                print("description not working")
                
                return nil }
        
        
        guard let thumbnail: YoutubeThumbnail = "thumbnails" <~~ json
            
            else {
                
                print("thumbnail not working")
                
                return nil }
        
        
        guard let channelId: String = "channelId" <~~ json
            
            else {
                
                print("id not working")
                
                return nil }
        
        
       
        
        guard let resource: YoutubeResource = "resourceId" <~~ json
            
            else {
                
                print("resource not working")
                
                return nil }
        
        
        self.title = title
        
        self.description = description
        
        self.thumbnail = thumbnail
        
        self.channelId = channelId
        
 
        
        self.resourceId = resource
        
    }
    
}



















import Foundation

import UIKit



class Updater {
    
   
  
    
    var search = VideoSearch()
    
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    // This determines the size of the split arrays and effects when the initial result array is split by setting a limit as to when the split occurs, and the returned page size from CableCast.
    
    /// Creates the NSURL session necessary to download content from remote URL.
    
    fileprivate func getNSURLSession() -> URLSession {
        
        //   let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        //  session.configuration.urlCache?.removeAllCachedResponses()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        return defaultSession
        
    }
    
    

    
    func checkCategory(string: String) -> CategoryFactorySettings? {
        
        let factory = NSClassFromString(string) as? CategoryFactorySettings.Type
        
        let factory1 = factory?.init()
        
        if(factory1 != nil) {
            
            return factory1
        }
        
        
        
        return home()
        
    }
    
    


    
      
}


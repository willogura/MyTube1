

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
    
    
    func createCategory() -> Category? {
        
        var category = home()
        
        var categoryOrderList = [CategoryOrder]()
        
        if((playlistIDs[safe: 0]) != nil){
            
            print("gets to first")
            
            category.featuredSectionPlaylist = playlistIDs[safe: 0]
            
            category.featuredSectionTitle = playlistTitles[safe:0]
            
            categoryOrderList.append(CategoryOrder.featured)
            
            category.categoryTitle = globalUsername
            
        }
        
        if((playlistIDs[safe: 1]) != nil){
            
            
               print("gets to second")
            category.featured2SectionPlaylist = playlistIDs[safe: 1]
            
            
             category.featured2SectionTitle = playlistTitles[safe:1]
            
            categoryOrderList.append(CategoryOrder.featured2)
            
            
        }
        
        if((playlistIDs[safe: 2]) != nil){
            
            category.featured3SectionPlaylist = playlistIDs[safe: 2]
            
            
             category.featured3SectionTitle = playlistTitles[safe:2]
            
            categoryOrderList.append(CategoryOrder.featured3)
            
            
        }
        
        category.categoryOrder = categoryOrderList
        
        
        if(categoryOrderList.count > 0) {
            
            print("gets here too \(category.featuredSectionPlaylist)")
            
            var newCategory = Category(categoryFactory: CategoryFactory(factorySettings: category))
            
            
       return newCategory
        
        
        }
        
        return Category(categoryFactory: CategoryFactory(factorySettings: home()))
        
        
    }
    
    


    
      
}


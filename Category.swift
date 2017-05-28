

import Foundation

import UIKit



var categories: [Category] = [Category(categoryFactory: CategoryFactory(factorySettings: home())) ]









enum VideoType {

    
    case youtube
    
    
    
    
}


class CategoryFactorySettings: NSObject {
    
    required override init() {
        
    }
    
    var categoryTitle: String?
    
    var videoType = VideoType.youtube
    
    
    
    
    
    var featuredSectionTitle: String?
    
    var featuredSectionSearchID: Int?
    
    var featuredSectionDisplayCount: Int?
    
    var featuredSectionPlaylist: String?
    
    

    
    
    var featured2SectionTitle: String?
    
    var featured2SectionSearchID: Int?
    
    var featured2SectionDisplayCount: Int?
    
    var featured2SectionPlaylist: String?
    

    var featured3SectionTitle: String?
    
    var featured3SectionSearchID: Int?
    
    var featured3SectionDisplayCount: Int?
    
    var featured3SectionPlaylist: String?
    
    
    
    
    var categoryOrder: [CategoryOrder]?
    
 
    

 
 
    
}

enum CategoryOrder {
    

    case featured
    
    case featured2
    
    case featured3
    
 

    
}









class CategoryFactory {
    
    
    var settings: CategoryFactorySettings
    
    
    
    init(factorySettings: CategoryFactorySettings) {
        
        self.settings = factorySettings
        
    }
    

    
    internal func addFeaturedSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.featuredSectionTitle
        
        let searchID = settings.featuredSectionSearchID
        
        let displayCount = settings.featuredSectionDisplayCount
        
        let videoList: [Int]? = nil
        
      
        
        let sectionPlaylist = settings.featuredSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList, displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    internal func addFeatured2Section() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.featured2SectionTitle
        
        let searchID = settings.featured2SectionSearchID
        
        let displayCount = settings.featured2SectionDisplayCount
        
        let videoList: [Int]? = nil
  
        
        let sectionPlaylist = settings.featured2SectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    internal func addFeatured3Section() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.featured3SectionTitle
        
        let searchID = settings.featured3SectionSearchID
        
        let displayCount = settings.featured3SectionDisplayCount
        
        let videoList: [Int]? = nil
        
      
        
        let sectionPlaylist = settings.featured3SectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    

    
    
    
    

    
    internal func getOrder() -> [CategoryOrder] {
        
        return settings.categoryOrder!
        
        
    }
}





class Category {
    
    
    var categoryFactory: CategoryFactory
    
    var categoryTitle: String
    
    var videoType: VideoType
    
    var sections = [Section]()
    
    var slider: Section?
    
    func getSlider() -> Section? {
        
        
        if(slider != nil) {
            
            return slider!
        }
        
        return nil
        
    }
    
    
    required init(categoryFactory: CategoryFactory) {
        
        self.categoryFactory = categoryFactory
        
        self.categoryTitle = categoryFactory.settings.categoryTitle!
        
        self.videoType = categoryFactory.settings.videoType
        
        
    }
    
    
    func createListing() {
        
        let order = categoryFactory.getOrder()
        
        
        
        for section in order {
            
            switch section {
                

                
            case CategoryOrder.featured:
                
                createFeaturedSection()
                
            case CategoryOrder.featured2:
                
                createFeatured2Section()
                
            case CategoryOrder.featured3:
                
                createFeatured3Section()
                
     
                
       
       
            
            
        }

        }
        
        
    }
    

    
    func createFeaturedSection() {
        
        sections.append(categoryFactory.addFeaturedSection())
        
        
        
    }
    
    func createFeatured2Section() {
        
        sections.append(categoryFactory.addFeatured2Section())
        
        
        
    }
    
    func createFeatured3Section() {
        
        sections.append(categoryFactory.addFeatured3Section())
        
        
        
    }
    
  




    
    func getSection(row: Int) -> Section {
        
        return sections[row]
        
    }



}




class Section {
    
    var sectionType: SectionType
    
    var displayCount:  Int?
    
    var sectionTitle: String?
    
    var sectionPlaylist: String?
    
    var searchID: Int?
    
    var videoList: [Int]?
    
  

    
    init(sectionType: SectionType, sectionTitle: String?, searchID: Int?, videoList: [Int]?, displayCount: Int?,  sectionPlaylist: String?) {
        
        self.sectionType = sectionType
        
        self.sectionTitle = sectionTitle
        
        self.searchID = searchID
        
        self.videoList = videoList
        
        self.sectionPlaylist = sectionPlaylist
        
    
        
        self.displayCount = displayCount
        
    }
    

    
   
    
    func getDisplayCount() -> Int? {
        
        return displayCount
        
    }
    
    
}

enum SectionType {
    
   
    
    case videoList
    

}


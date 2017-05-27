//
//  Category.swift
//  HalfTunes
//
//  Created by William Ogura on 11/17/16.
//
//

import Foundation

import UIKit



var categories: [Category] = [Category(categoryFactory: CategoryFactory(factorySettings: home())) ]









enum VideoType {
    
    case cablecast
    
    case youtube
    
    
    
    
}


class CategoryFactorySettings: NSObject {
    
    required override init() {
        
    }
    
    var categoryTitle: String?
    
    var videoType = VideoType.cablecast
    
    
    
    var upcomingSectionTitle: String?
    
    var upcomingSectionSearchID: Int?
    
    var upcomingSectionDisplayCount: Int?
    
    var upcomingSectionPlaylist: String?
    
    
    var popularSectionTitle: String?
    
    var popularSectionSearchID: Int?
    
    var popularSectionDisplayCount: Int?
    
    var popularSectionPlaylist: String?
    
    
    var recentGirlsSectionTitle: String?
    
    var recentGirlsSectionSearchID: Int?
    
    var recentGirlsSectionDisplayCount: Int?
    
    var recentGirlsSectionPlaylist: String?
    
    
    var recentBoysSectionTitle: String?
    
    var recentBoysSectionSearchID: Int?
    
    var recentBoysSectionDisplayCount: Int?
    
    var recentBoysSectionPlaylist: String?
    
    
    
    var featuredSectionTitle: String?
    
    var featuredSectionSearchID: Int?
    
    var featuredSectionDisplayCount: Int?
    
    var featuredSectionPlaylist: String?
    
    
    
    var recent2SectionTitle: String?
    
    var recent2SectionSearchID: Int?
    
    var recent2SectionDisplayCount: Int?
    
    var recent2SectionPlaylist: String?
    
    
    
    var recentSectionTitle: String?
    
    var recentSectionSearchID: Int?
    
    var recentSectionDisplayCount: Int?
    
    var recentSectionPlaylist: String?
    
    
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
    
    case upcoming
    
    case recent
    
    case recent2
    
    case featured
    
    case featured2
    
    case featured3
    
    case popular
    
    case girls
    
    case boys
    

    
}









class CategoryFactory {
    
    
    var settings: CategoryFactorySettings
    
    
    
    init(factorySettings: CategoryFactorySettings) {
        
        self.settings = factorySettings
        
    }
    
    
    internal func addUpcomingSection() -> Section {
        
        let sectionType = SectionType.upcomingEventList
        
        let sectionTitle = settings.upcomingSectionTitle
        
        let searchID = settings.upcomingSectionSearchID
        
        let displayCount = settings.upcomingSectionDisplayCount
        
        let videoList: [Int]? = nil
        
     
        
        let sectionPlaylist = settings.upcomingSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
    }
    
    internal func addPopularSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.popularSectionTitle
        
        let searchID = settings.popularSectionSearchID
        
        let displayCount = settings.popularSectionDisplayCount
        
        let videoList: [Int]? = nil
        
      
        
        let sectionPlaylist = settings.popularSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
    }
    
    internal func addRecentGirlsSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentGirlsSectionTitle
        
        let searchID = settings.recentGirlsSectionSearchID
        
        let displayCount = settings.recentGirlsSectionDisplayCount
        
        let videoList: [Int]? = nil
        
     
        
        let sectionPlaylist = settings.recentGirlsSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount, sectionPlaylist: sectionPlaylist)
        return section
        
        
    }
    
    internal func addRecentBoysSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentBoysSectionTitle
        
        let searchID = settings.recentBoysSectionSearchID
        
        let displayCount = settings.recentBoysSectionDisplayCount
        
        let videoList: [Int]? = nil
        
       
        
        let sectionPlaylist = settings.recentBoysSectionPlaylist
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
        
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
    
    internal func addRecentSection() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recentSectionTitle
        
        let searchID = settings.recentSectionSearchID
        
        let displayCount = settings.recentSectionDisplayCount
        
        let sectionPlaylist = settings.recentSectionPlaylist
        
        let videoList: [Int]? = nil
        
    
        
        let images: [UIImage]? = nil
        
        let section = Section(sectionType: sectionType, sectionTitle: sectionTitle, searchID: searchID, videoList: videoList,  displayCount: displayCount,  sectionPlaylist: sectionPlaylist)
        
        return section
        
    }
    
    
    internal func addRecent2Section() -> Section {
        
        let sectionType = SectionType.videoList
        
        let sectionTitle = settings.recent2SectionTitle
        
        let searchID = settings.recent2SectionSearchID
        
        let displayCount = settings.recent2SectionDisplayCount
        
        let sectionPlaylist = settings.recent2SectionPlaylist
        
        let videoList: [Int]? = nil
        
   
        
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
                
            case CategoryOrder.upcoming:
                
                createUpcomingSection()
                
            case CategoryOrder.recent:
                
                createRecentSection()
                
            case CategoryOrder.recent2:
                
                createRecent2Section()
                
            case CategoryOrder.popular:
                
                createPopularSection()
                
            case CategoryOrder.featured:
                
                createFeaturedSection()
                
            case CategoryOrder.featured2:
                
                createFeatured2Section()
                
            case CategoryOrder.featured3:
                
                createFeatured3Section()
                
     
                
            case CategoryOrder.boys:
                
                createRecentBoysSection()
                
            case CategoryOrder.girls:
                
                createRecentGirlsSection()

            
       
            
            
        }

        }
        
        
    }
    
    func createUpcomingSection() {
        
        sections.append(categoryFactory.addUpcomingSection())
        
        
        
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
    
  
    func createRecentSection() {
        
        sections.append(categoryFactory.addRecentSection())
        
    }
    
    func createRecent2Section() {
        
        sections.append(categoryFactory.addRecent2Section())
        
    }
    
    func createRecentBoysSection() {
        
        sections.append(categoryFactory.addRecentBoysSection())
        
    }
    
    func createRecentGirlsSection() {
        
        sections.append(categoryFactory.addRecentGirlsSection())
        
    }
    
    func createPopularSection() {
        
        sections.append(categoryFactory.addPopularSection())
        
    }
    
    func createSpecificSection() {
        
        
    }
    
    func createSpecificSearchSection() {
        
        
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
    
    case buttonNoTitle
    
    case videoList
    
    case buttonWithTitle
    
    case slider
    
    case specificVideoList
    
    case upcomingEventList
    
    case squareButtonWithTitle
    
}


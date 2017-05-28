

import Foundation

import UIKit



@objc(home)

class home: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "MyTube"
        
        
     
        
        self.videoType = VideoType.youtube
        
        self.featuredSectionTitle = "Destiny 2"
        
        self.featuredSectionSearchID = 2
        
        self.featuredSectionDisplayCount = 15
        
        self.featuredSectionPlaylist = "PLpg6WLs8kxGP44oli7SB8_kQWutJ4wgjD"
        
        
        
        
        
        
        
        
        self.featured3SectionTitle = "Zelda"
        
        self.featured3SectionSearchID = 1
        
        self.featured3SectionDisplayCount = 15
        
        self.featured3SectionPlaylist = "PLpg6WLs8kxGOQI_C8UsMFcXfki8gAZW_I"
        
        

        

        
        self.featured2SectionTitle = "GameSpot Reviews"
        
        self.featured2SectionSearchID = 4
        
        self.featured2SectionDisplayCount = 15
        
        self.featured2SectionPlaylist = "PLpg6WLs8kxGNKAYeeayfQfYlfhpZ4lmP0"
        
        
        
        
       
        
        self.categoryOrder = [ CategoryOrder.featured, CategoryOrder.featured2,  CategoryOrder.featured3]    }
    
}




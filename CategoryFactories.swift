//
//  CategoryButtons.swift
//  CTV App
//
//  Created by William Ogura on 1/11/17.

//

import Foundation

import UIKit



@objc(home)

class home: CategoryFactorySettings {
    
    
    required init() {
        
        super.init()
        
        self.categoryTitle = "Home"
        
        
     
        
        self.videoType = VideoType.youtube
        
        self.recent2SectionTitle = "Uploads"
        
        self.recent2SectionSearchID = 2
        
        self.recent2SectionDisplayCount = 15
        
        self.recent2SectionPlaylist = "UUItaxOh-FCAiD2Hjqt1KlEw"
        
        
        
        
        
        
        
        
        self.popularSectionTitle = "CreaTV Episodes"
        
        self.popularSectionSearchID = 1
        
        self.popularSectionDisplayCount = 15
        
        self.popularSectionPlaylist = "PLc4OSwdRXG_KJwyC0WFroPmqwA67PAhZI"
        
        
        self.recentSectionTitle = "Summers @ the Station"
        
        self.recentSectionSearchID = 2
        
        self.recentSectionDisplayCount = 15
        
        self.recentSectionPlaylist = "PLc4OSwdRXG_JCNGQSDREaQqAyYOc8Yfbd"
        
        
        
        
        self.featuredSectionTitle = "Teens Interns"
        
        self.featuredSectionSearchID = 3
        
        self.featuredSectionDisplayCount = 15
        
        self.featuredSectionPlaylist = "PLc4OSwdRXG_LFv2E0tko6PzweN-GQ1KB1"
        
        self.recentBoysSectionTitle = "Young Lenses"
        
        self.recentBoysSectionSearchID = 4
        
        self.recentBoysSectionDisplayCount = 15
        
        self.recentBoysSectionPlaylist = "PLc4OSwdRXG_J0LTEtHVsx-zBH6sF39Nvs"
        
        
        
        
        
       
        
        self.categoryOrder = [CategoryOrder.recent2,CategoryOrder.popular, CategoryOrder.recent, CategoryOrder.featured, CategoryOrder.boys]    }
    
}




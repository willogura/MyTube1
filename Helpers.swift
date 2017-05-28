

import Foundation
import UIKit


extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}





extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    
    subscript (safe index: Index) -> Generator.Element? {
        
        return indices.contains(index) ? self[index] : nil
        
    }
}




import Foundation

import UIKit

protocol VideoCellDelegate {
    
  
    
    func thumbnailTapped(_ cell: VideoCell)
    
}

class VideoCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var thumbnailView: UIImageView!
    
  
    
    @IBOutlet weak var titleLabel: UILabel!
    
 
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    // var delegate: VideoCellDelegate?
    
    var delegate:VideoCellDelegate! = nil
    
    @IBOutlet weak var thumbnailButton: UIButton!
    

    
    @IBAction func thumbnailTapped(_ sender: AnyObject) {
        
        delegate?.thumbnailTapped(self)
        
    }

    
}

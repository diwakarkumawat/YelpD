//
//  BusinessCell.swift
//  Yelp
//
//  Created by Kumawat, Diwakar on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    

    var business: Business! {
        didSet {
            nameLabel.text = business.name
            distanceLabel.text = business.distance
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            thumbImageView.setImageWith(business.imageURL!)
            ratingImageView.setImageWith(business.ratingImageURL!)
            reviewsCountLabel.text = "\(business.reviewCount!)"
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

//
//  ResturantTableViewCell.swift
//  YelpIt
//
//  Created by Sudipta Bhowmik on 11/6/17.
//  Copyright © 2017 Sudipta Bhowmik. All rights reserved.
//

import UIKit

class ResturantTableViewCell: UITableViewCell {
    //MARK :- Outlets
    @IBOutlet weak var restaurantImgView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ReviewsLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var starsImgView: UIImageView!
    
    //MARK :- Variables
    var business : Business! {
        didSet {
            //print("here")
            restaurantImgView.setImageWith(business.imageURL!)
            restaurantNameLabel.text = business.name
            ReviewsLabel.text = "\(business.reviewCount ?? 0) Reviews"
            categoryLabel.text = business.categories
            distanceLabel.text = business.distance
            addressLabel.text = business.address
            starsImgView.image = business.ratingImage
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Rounded corners for image view
        restaurantImgView.layer.cornerRadius = 3
        restaurantImgView.clipsToBounds = true
        
        //Set the name label width according to labels width since sometimes it can go out of sync in case of device orientation changes
        restaurantNameLabel.preferredMaxLayoutWidth = restaurantNameLabel.frame.size.width
    }

    //set the label width to actual width of label. This is needed to fit label width in case orientation is changed from portrait to landscape
    override func layoutSubviews() {
        super.layoutSubviews()
        restaurantNameLabel.preferredMaxLayoutWidth = restaurantNameLabel.frame.size.width
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

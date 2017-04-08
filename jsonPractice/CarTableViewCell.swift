//
//  CarTableViewCell.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/7/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import UIKit
import Kingfisher

class CarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var makerLabel: UILabel!
    @IBOutlet weak var cleanLabel: UILabel!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    
    func fillWithModel(car: Car) {
        
        styleViews()
        
        nameLabel.text         = car.name
        makerLabel.text        = car.make
        cleanLabel.text        = car.innerCleanliness.replacingOccurrences(of: "_", with: " ")
        transmissionLabel.text = getTransmission(transmission: car.transmission)
        carTypeLabel.text      = car.group
    
        
        
        let finalImageUrl = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(car.modelIdentifier)/\(car.color)/2x/car.png"
        if let imageNSURL = URL(string: finalImageUrl) {
            carImageView.kf.setImage(with: imageNSURL, placeholder: #imageLiteral(resourceName: "ic_car"), options: [], progressBlock: nil, completionHandler: nil)

        }
    }

    
    
    func getTransmission(transmission: String) -> String {
        switch transmission.uppercased() {
        case "M":
            return "MANUAL"
        case "A":
            return "AUTOMATIC"
        default:
            return "UNKNOWN"
        }
    }
    
    func styleViews()  {

        transmissionLabel.backgroundColor    = .lightGray
        transmissionLabel.layer.cornerRadius = 5
        transmissionLabel.clipsToBounds      = true
        
        carImageView.layer.cornerRadius      = 35
        carImageView.backgroundColor         = .lightGray
        carImageView.contentMode                = .scaleAspectFit
    }

}

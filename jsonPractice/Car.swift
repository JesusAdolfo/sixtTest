//
//  Car.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/7/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import SwiftyJSON

struct Car {
    
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let make: String
    let group: String
    let color: String
    let series: String
    let fuelType: String
    let fuelLevel: Float
    let transmission: String
    let licensePlate: String
    let latitude: Float
    let longitude: Float
    let innerCleanliness: String
    let imageUrl: String
    
    init(json: JSON) {
        self.id               = json["id"].stringValue
        self.modelIdentifier  = json["modelIdentifier"].stringValue
        self.modelName        = json["modelName"].stringValue
        self.name             = json["name"].stringValue
        self.make             = json["make"].stringValue
        self.group            = json["group"].stringValue
        self.color            = json["color"].stringValue
        self.series           = json["series"].stringValue
        self.fuelType         = json["fuelType"].stringValue
        self.fuelLevel        = json["fuelLevel"].floatValue
        self.transmission     = json["transmission"].stringValue
        self.licensePlate     = json["licensePlate"].stringValue
        self.latitude         = json["latitude"].floatValue
        self.longitude        = json["longitude"].floatValue
        self.innerCleanliness = json["innerCleanliness"].stringValue
        self.imageUrl         = json["carImageUrl"].stringValue
        
    }
}

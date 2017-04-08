//
//  CarsDataSouce.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/7/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import TRON
import SwiftyJSON

class CarsDataSource: JSONDecodable {
    
    let cars: [Car]
    
    required init(json: JSON) throws {
        guard let carsJsonArray = json.array else {
            throw NSError(domain: "jesus", code: 1, userInfo: [NSLocalizedDescriptionKey: "Entity not valid in JSON"])
        }

        self.cars = carsJsonArray .map({return Car(json: $0)})
        
    }
    
    
}

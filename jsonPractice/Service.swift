//
//  Service.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/7/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "http://www.codetalk.de")
    static let sharedInstance = Service()
    
    
    func fetchCarsFeed(completion: @escaping (CarsDataSource?, Error?) -> ()){
        print("Fetching home feed")
        let request: APIRequest <CarsDataSource, JSONError> = tron.request("/cars.json")
        
        
        
        request.perform(withSuccess: { (carsDataSource) in
            print("Successfuly fetched our JSON")
            completion(carsDataSource, nil)
        }) { (err) in
            
            print("We had an error fetching JSON ", err)
            completion(nil, err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}

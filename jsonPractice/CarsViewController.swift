//
//  ViewController.swift
//  sixtTest
//
//  Created by Jesus Adolfo on 4/5/17.
//  Copyright © 2017 adolfo. All rights reserved.
//

import UIKit
import TRON

class CarsViewController: UIViewController {
    
    var showNoResult = false
    var refreshControl: UIRefreshControl!
    
    var cars = [Car]()

    @IBOutlet var myTableView: UITableView!
    var stuff = ["first thing", "second thing"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNoResultsCell()
        registerCarCell()
        
        updateCarsFeed()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(updateCarsFeed), for: UIControlEvents.valueChanged)
        myTableView.addSubview(refreshControl)
        
        
    }

    
    func updateCarsFeed()  {
        Service.sharedInstance.fetchCarsFeed { (carsDataSource, err) in
            if let err = err {
                if let _ = err as? APIError<Service.JSONError> {
                    self.showNoResult = true
                }
                return
            }
            self.cars = (carsDataSource?.cars)!
            self.myTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func registerNoResultsCell() {
        let noresultsNib = UINib(nibName: "NoResultTableViewCell", bundle: nil)
        myTableView.register(noresultsNib, forCellReuseIdentifier: "noresult_cell")
    }
    
    func registerCarCell() {
        let campaignCell = UINib(nibName: "CarTableViewCell", bundle: nil)
        myTableView.register(campaignCell, forCellReuseIdentifier: "car_cell")
    }

    
}


extension CarsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = cars.count
        
        if rows == 0 {
            showNoResult = true
            return 1
        }else{
            showNoResult = false
            return rows
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if showNoResult == true {
            let cell = myTableView.dequeueReusableCell(withIdentifier: "noresult_cell", for: indexPath)
            return cell
        }
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "car_cell", for: indexPath) as! CarTableViewCell
        cell.fillWithModel(car: cars[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if showNoResult == true {
            return tableView.frame.height
        }
        return 100
    }
    
}

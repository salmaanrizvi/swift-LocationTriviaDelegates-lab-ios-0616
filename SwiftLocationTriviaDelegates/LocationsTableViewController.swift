//
//  LocationsTableViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Salmaan Rizvi on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController, AddLocationViewControllerDelegate {

    weak var addLocationVC : AddLocationViewController?
    var locations : [Location] = []
    
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func addLocationViewControllerDidCancel(viewController: AddLocationViewController) {
        
        viewController.dismissViewControllerAnimated(true, completion: {
            print("Dismissed Add Location VC after tapping Cancel.")
        })
    }
    
    func addLocationViewController(viewController: AddLocationViewController, didAddLocationNamed name: String) {
        
        locations.append(Location(name: name, trivia: []))
        self.tableView.reloadData()
        viewController.dismissViewControllerAnimated(true, completion: {
            print("Dismissed Add Location VC location added.")
        })
    }
    
    func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool {
        
        for location in locations {
            print("Location: \(location.name)")
            if location.name == name {
                return false
            }
        }
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = locations[indexPath.row].name
        cell.detailTextLabel!.text = String(locations[indexPath.row].trivia.count)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.addLocationVC = segue.destinationViewController as? AddLocationViewController
        self.addLocationVC?.delegate = self
    }
    
}

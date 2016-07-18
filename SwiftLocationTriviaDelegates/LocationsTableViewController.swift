//
//  LocationsTableViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Haaris Muneer on 7/14/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController {
    
    var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("locationCell") else { print("error getting cell"); return UITableViewCell() }
        let currentLocation = locations[indexPath.row]
        cell.textLabel?.text = currentLocation.name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let addLocationVC = segue.destinationViewController as? AddLocationViewController else { print("Error getting the Add Location VC"); return }
        addLocationVC.delegate = self
    }

    @IBAction func addButtonTapped(sender: AnyObject) {
        
    }

}

extension LocationsTableViewController: AddLocationViewControllerDelegate {
    func addLocationViewControllerDidCancel(viewController: AddLocationViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationNamed name: String) -> Bool {
        for location in locations {
            if location.name == name {
                return false
            }
        }
        return true
    }
    
    func addLocationViewController(viewController: AddLocationViewController, didAddLocationNamed name: String) {
        if addLocationViewController(viewController, shouldAllowLocationNamed: name) {
            locations.append(Location(name: name, trivia: []))
            viewController.dismissViewControllerAnimated(true, completion: nil)
            self.tableView.reloadData()
        }
    }
}



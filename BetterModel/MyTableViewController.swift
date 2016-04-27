//
//  MyTableViewController.swift
//  BetterModel
//
//  Created by Thomas White on 4/14/16.
//  Copyright © 2016 TH White Consulting. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController, DetailViewControllerDelegate {

    var dataList: [Model]?
    var indexOfSelection: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataList = [Model]()
        
        let first = Model(name: "Bob", grade: 70)
        let second = Model(name: "Sue", grade: 80)
        let third = Model(name: "George", grade: 90)
        
        dataList = [first, second, third]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList!.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let gradeLabel = cell.viewWithTag(1001) as! UILabel
        
        nameLabel.text = dataList![indexPath.row].name
        gradeLabel.text = String(dataList![indexPath.row].grade)
        
        return cell
    }

    func detailViewControllerDidCancel(controller: DetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func detailViewController(controller: DetailViewController, didFinishAddingItem item: Model) {
        let newModel = item
        dataList?.append(newModel)
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func detailViewController(controller: DetailViewController, didFinishEditingItem item: Model) {
        let editedModel = item
        dataList![indexOfSelection!] = editedModel
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! DetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = dataList![indexPath.row]
                indexOfSelection = indexPath.row
            }
        } else if segue.identifier == "AddItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! DetailViewController
            controller.delegate = self
            controller.itemToEdit = nil
        }
    }
}

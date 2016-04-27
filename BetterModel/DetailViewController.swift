//
//  DetailViewController.swift
//  BetterModel
//
//  Created by Thomas White on 4/18/16.
//  Copyright © 2016 TH White Consulting. All rights reserved.
//

import UIKit
protocol DetailViewControllerDelegate: class {
    func detailViewControllerDidCancel(controller: DetailViewController)
    func detailViewController(controller: DetailViewController, didFinishAddingItem item: Model)
    func detailViewController(controller: DetailViewController, didFinishEditingItem item: Model)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var gradeField: UITextField!
    
    var itemToEdit: Model?
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = itemToEdit {
            title = "Editing"
            nameField.text = item.name
            let temp = String(item.grade)
            gradeField.text = temp
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        delegate?.detailViewControllerDidCancel(self)
    }
    
    @IBAction func done(sender: AnyObject) {
        if let item = itemToEdit {
            item.name = nameField.text!
            let temp = Int(gradeField.text!)
            item.grade = temp!
            delegate?.detailViewController(self, didFinishEditingItem: item)
        } else {
            if let tempName = nameField.text {
                if let tempGrade = Int(gradeField.text!) {
                    let item = Model(name: tempName, grade: tempGrade)
                    delegate?.detailViewController(self, didFinishAddingItem: item)
                } else {
                    delegate?.detailViewControllerDidCancel(self)
                }
            } else {
                delegate?.detailViewControllerDidCancel(self)
            }
        }
       
    }
}

//
//  ResultsViewController.swift
//  E-testing
//
//  Created by tom on 07.12.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation
import UIKit
import Cake


struct Category {
    let amount: Double
    let color: UIColor
    let name: String
}

struct Category2 {
    let amount: Double
    let color: UIColor
    let name: String
}

class ResultsController: UIViewController, CakeViewAccessibilityDataSource, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cakeView: CakeView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var cakeView2: CakeView!
    //@IBOutlet weak var cakeView3: CakeView!
    
    
    //var neco: CakeGraph = CakeGraph(cakeView: cakeView2)
    //var neco: CakeGraph? //Calls init and creates an instance
    //neco.cakeView = self.cakeView2
    
    
    
    let categories = [
        Category(amount: 89, color: UIColor(red: 255, green: 255, blue: 255, alpha: 1), name: "Aktuální"),
        Category(amount: 11, color: UIColor(red: 251/255, green: 99/255, blue: 90/255, alpha: 0), name: ""),
        ]
    
    var totalAmount: Double {
        return categories[0].amount
        //return categories.lazy.map { $0.amount }.reduce(0, combine: +)
    }
    
    let categories2 = [
        Category2(amount: 70, color: UIColor(red: 0, green: 45, blue: 178, alpha: 1), name: "Nejlepší"),
        Category2(amount: 30, color: UIColor(red: 251/255, green: 99/255, blue: 90/255, alpha: 0), name: ""),
        ]
    var totalAmount2: Double {
        return categories2[0].amount
        //return categories2.lazy.map { $0.amount }.reduce(0, combine: +)
    }
    
    let categories3 = [
        Category(amount: 77, color: UIColor(red: 56/255, green: 138/255, blue: 226/255, alpha: 1), name: "Průměr"),
        Category(amount: 23, color: UIColor(red: 251/255, green: 99/255, blue: 90/255, alpha: 0), name: ""),
        ]
    var totalAmount3: Double {
        return categories3[0].amount
        //return categories3.lazy.map { $0.amount }.reduce(0, combine: +)
    }
    
    let percentageFormatter: NSNumberFormatter = {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .PercentStyle
        return numberFormatter
    }()
    
    @IBAction func Repeat(sender: AnyObject) {
    }
    
    
    var numberToDisplay = 0
    var subjects = [Subject]()
    var items = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // cakeView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        //neco.cakeView(cakeView2, fillColorForSegmentAtIndex: 1)
        //neco.cakeView(cakeView2, valueForSegmentAtIndex: 1)
        
        cakeView.dataSource = self
        cakeView.segmentWidth = 10
        cakeView.segmentRadius = 50
        
        /*cakeView2.dataSource = self
         cakeView2.segmentRadius = 45
         cakeView2.segmentWidth = 4
         
         cakeView3.dataSource = self
         cakeView3.segmentRadius = 40
         cakeView3.segmentWidth = 4 */
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.view.contentMode = UIViewContentMode.ScaleAspectFill //doesnt seem to do anything!
        self.view.clipsToBounds = true
        self.view.center = view.center
        
        
        total.text =  String(format:"%.f", totalAmount) + "%" // String(format:"%f", totalAmount) = prevedeni cisla na retezec, + "%" prevedeni znaku.
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ResultsViewController.cakeViewDidSelectSegment(_:)), name: CakeViewDidSelectSegmentNotification, object: CakeView)
    }
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        let percent = category.amount / totalAmount
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DefaultCell", forIndexPath: indexPath) as! CategCell
        cell.categoryTitleLabel.text = category.name
        cell.percentageLabel.text = percentageFormatter.stringFromNumber(percent)
        cell.percentageProgressView.progress = Float(percent)
        cell.percentageProgressView.progressTintColor = category.color
        // cell.amountLabel.text = currencyFormatter.stringFromNumber(category.amount)
        cell.categoryImageView.tintColor = category.color
        //cell.categoryImageView.image = category.image
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cakeView.selectedSegmentIndex = indexPath.row
    }
    
    // MARK: - Cake View
    
    func numberOfSegmentsInCakeView(cakeView: CakeView) -> Int {
        return categories.count
    }
    
    func cakeView(cakeView: CakeView, fillColorForSegmentAtIndex index: Int) -> UIColor {
        return categories[index].color
    }
    
    func cakeView(cakeView: CakeView, valueForSegmentAtIndex index: Int) -> Double {
        return categories[index].amount
    }
    
    func cakeView(cakeView: CakeView, accessibilityLabelForSegmentAtIndex index: Int) -> String? {
        let category = categories[index]
        return category.name
    }
    
    func cakeView(cakeView: CakeView, accessibilityValueForSegmentAtIndex index: Int) -> String? {
        _ = categories[index]
        
        
        
        return " "
    }
    
    
    /* func numberOfSegmentsInCakeView2(cakeView: CakeView) -> Int {
     return categories2.count
     }
     
     func cakeView2(cakeView2: CakeView, fillColorForSegmentAtIndex index: Int) -> UIColor {
     return categories2[index].color
     }
     
     func cakeView2(cakeView2: CakeView, valueForSegmentAtIndex index: Int) -> Double {
     return categories2[index].amount
     }
     
     func cakeView2(cakeView2: CakeView, accessibilityLabelForSegmentAtIndex index: Int) -> String? {
     let category = categories2[index]
     return category.name
     }
     
     func cakeView2(cakeView2: CakeView, accessibilityValueForSegmentAtIndex index: Int) -> String? {
     _ = categories2[index]
     
     
     
     return " "
     } */
    
    
    func cakeViewDidSelectSegment(note: NSNotification) {
        guard let index = note.userInfo?[CakeViewNewSegmentIndexUserInfoKey] as? Int else { return }
        
        if index != CakeViewNoSegment {
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: .None)
        } else if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    
    @IBAction func Exit(sender: AnyObject) {
        exit(0)
    }
}


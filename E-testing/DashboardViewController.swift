//
//  DashboardViewController.swift
//  E-testing
//
//  Created by Ondřej David on 09.08.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import FoldingCell
import UIKit
import LACircleChartView


@IBDesignable
class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var subjectTableView: UITableView!
    
    @IBOutlet weak var circle: LACircleView!
    
    @IBAction func course(sender: UIButton) {
        _ = sender.tag
    }
    
    var subjects = [Subject]()
    var cellHeights = [CGFloat]()
    var imageView: UIImageView!
    var scrollView: UIScrollView!
    
    let kCloseCellHeight: CGFloat = 100
    let kOpenCellHeight: CGFloat = 200
    
    
    convenience init(frame: CGRect) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.view.contentMode = UIViewContentMode.ScaleAspectFill //doesnt seem to do anything!
        self.view.clipsToBounds = true
        self.view.center = view.center
        self.subjectTableView.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.loadSampleSubjects()
        
        /* NSLayoutConstraint(item: DashboardViewController.self, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 0.0).active = true
         NSLayoutConstraint(item: DashboardViewController.self, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: 0.0).active = true
         NSLayoutConstraint(item: DashboardViewController.self, attribute: .Height, relatedBy: .Equal, toItem: view, attribute:.Width, multiplier: 2.0, constant:0.0).active = true
         */
        
        
        /*let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
         dispatch_after(delayTime, dispatch_get_main_queue()) {
         self.circle.drawStroke()
         }*/
        
        
        for _ in 0...subjects.count {
            cellHeights.append(kCloseCellHeight)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /* override func viewDidAppear(animated: Bool) {
     super.viewDidAppear(animated)
     let alert = UIAlertController(title: "Upozornění", message: "Není možné aktualizovat data aplikace", preferredStyle: UIAlertControllerStyle.Alert)
     alert.addAction(UIAlertAction(title: "Zrušit", style: UIAlertActionStyle.Default, handler: nil))
     alert.addAction(UIAlertAction(title: "Znovu", style: UIAlertActionStyle.Default, handler: nil))
     
     self.presentViewController(alert, animated: true, completion: nil)
     
     
     } */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* @IBAction func percentChanged(sender: UISlider) {
     self.circle1.progress = CGFloat(sender.value)
     }
     
     @IBAction func circleOfPercentChanged(sender: UISlider) {
     self.circle1.percentOfCircle = CGFloat(sender.value)
     } */
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // hide attachment section if there are none
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("folldingCell", forIndexPath: indexPath) as! FoldingCell
        
        let subject = subjects[indexPath.row]
        
        if (subject.tested == false){
            cell.foregroundPercentageView.backgroundColor = TestResult.notTested.color
        }
        
        if (subject.rating > 0 && subject.rating <= 60){
            cell.foregroundPercentageView.backgroundColor = TestResult.fail.color
        }
        
        if (subject.rating > 60){
            cell.foregroundPercentageView.backgroundColor = TestResult.success.color
        }
        
        cell.subjectLabel.text = subject.name
        cell.subjectLabelBackground.text = subject.name
        cell.courseButton.tag = indexPath.row
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell is FoldingCell {
            let foldingCell = cell as! FoldingCell
            
            if cellHeights[indexPath.row] == kCloseCellHeight {
                foldingCell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                foldingCell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
        
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
    }
    
    var counter = 0
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let test = segue.identifier {
            print(test)
        }
        
        let index = sender?.tag
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        switch(segue.identifier!) {
        case "CourseView":
            if let courseView = segue.destinationViewController as? CourseViewController{
                courseView.numberToDisplay = counter
                courseView.subjects.append(subjects[index!])
            }
            break
        case "DetailView":
            if let detailView = segue.destinationViewController as? DetailController{
                detailView.numberToDisplay = counter
                detailView.subjects.append(subjects[index!])
            }
            
            break
        case "ResultsView":
            if let resultsView = segue.destinationViewController as? ResultsController {
                resultsView.numberToDisplay = counter
                resultsView.subjects.append(subjects[index!])
            }
            break
        default:
            break
            
        }
        
        
        
        /*  if segue.identifier == "CourseView"{
         if let courseView = segue.destinationViewController as? CourseViewController{
         courseView.numberToDisplay = counter
         courseView.subjects.append(subjects[index])
         }
         }
         
         if segue.identifier == "DetailView"{
         if let detailView = segue.destinationViewController as? DetailController{
         detailView.numberToDisplay = counter
         detailView.subjects.append(subjects[index])
         }
         }
         
         if segue.identifier == "ResultView"{
         if let resultView = segue.destinationViewController as? ResultsController {
         resultView.numberToDisplay = counter
         resultView.subjects.append(subjects[index!])
         }
         //let destinationVC = segue.destinationViewController as! CourseViewController
         let index = sender?.tag
         let backItem = UIBarButtonItem()
         backItem.title = ""
         navigationItem.backBarButtonItem = backItem
         
         }*/
    }
    
    
    func loadSampleSubjects() {
        
        let subject1 = Subject(name: "Matematika", rating: 56, tested: true)
        let subject2 = Subject(name: "Lineární algebra", rating: 45, tested: true)
        let subject3 = Subject(name: "Programování", rating: 0, tested: false)
        let subject4 = Subject(name: "Java", rating: 56, tested: true)
        let subject5 = Subject(name: "C#", rating: 73, tested: true)
        let subject6 = Subject(name: "C++", rating: 87, tested: true)
        subjects += [subject1, subject2, subject3, subject4, subject5, subject6]
        
    }
}
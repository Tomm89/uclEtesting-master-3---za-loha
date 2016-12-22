//
//  DetailViewController.swift
//  E-testing
//
//  Created by tom on 07.12.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation
import UIKit

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var table: UITableView!
    
    var numberToDisplay = 0
    var subjects = [Subject]()
    var answers = [String]()
    var courseDetail = Json4Swift_Base()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // deklarace údáju z JSON souboru (model.swift - rozparserovaný json)
        
        if let path = NSBundle.mainBundle().pathForResource("UCL", ofType: "json"){  //název json souboru s příponou
            let fm = NSFileManager()
            let exists = fm.fileExistsAtPath(path)
            if(exists){
                let c = fm.contentsAtPath(path)
                let cString = NSString(data: c!, encoding: NSUTF8StringEncoding)
                if let data = cString!.dataUsingEncoding(NSUTF8StringEncoding) {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
                        let data = Json4Swift_Base(dictionary: json!)
                        print(data?.name)
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
                print(cString)
                
            }
        }
        
        
        
        loadsampleAnswers()
        
        self.table.delegate = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.view.contentMode = UIViewContentMode.ScaleAspectFill //doesnt seem to do anything!
        self.view.clipsToBounds = true
        self.view.center = view.center
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        table.reloadData()
        
    }
    
    private func loadsampleAnswers() {
        
        let answer1 = String("Odpověď1")
        let answer2 = String("Odpověď2")
        let answer3 = String("Odpověď3")
        
        answers += [answer1, answer2, answer3]
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.scrollEnabled = false
        
        return self.answers.count
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("answerRow", forIndexPath: indexPath) as! AnswerRow
        cell.checkImage.hidden = false
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("answerRow", forIndexPath: indexPath) as! AnswerRow
        
        cell.label.text = answers[indexPath.row]
        
        return cell
    }
    
}


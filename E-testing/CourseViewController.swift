//
//  CourseViewController.swift
//  E-testing
//
//  Created by Ondřej David on 26.09.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import UIKit
import iCarousel

class CourseViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    
    var numberToDisplay = 0
    var subjects = [Subject]()
    var items = [String]()
    //var courseDetail = Json4Swift_Base()
    
    
    @IBOutlet weak var carousel: iCarousel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  if let path = NSBundle.mainBundle().pathForResource("UCL", ofType: "json"){
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
         }  */
        
        
        self.navigationItem.title = subjects[0].name
        carousel.type = .CoverFlow
        //carousel.type = .Linear
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor();
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        items.append("Číselné obory, zobrazení, funkce")
        items.append("Číselné obory, zobrazení, funkce")
        items.append("Číselné obory, zobrazení, funkce")
        items.append("Číselné obory, zobrazení, funkce")
        //for i in 0 ... 99 {
        // items.append(i)
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return items.count
    }
    
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame: CGRect(x: 20, y: 0, width: 325, height: 370))
            itemView.backgroundColor = UIColor.whiteColor()
            //itemView.image = UIImage(named: "page")
            itemView.contentMode = .Center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = UIColor.clearColor()
            label.textAlignment = .Center
            label.font = label.font.fontWithSize(18)
            label.tag = 1
            itemView.addSubview(label)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(items[index])"
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .Spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        let item = self.items[index]
        print(item)
    }
    
}

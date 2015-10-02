//
//  EmbalsesTableViewController.swift
//  Embalses
//
//  Created by Jorge Perez on 9/29/15.
//  Copyright © 2015 Jorge Perez. All rights reserved.
//

import UIKit
import Kanna

class EmbalsesTableViewController: UITableViewController {
    
    var myNewDictArray:[Dictionary<Int, String>] = []
    var nextScreenRow:Int = 0
    
    @IBOutlet var embalsesTable: UITableView!
    
    
    
    override func viewWillAppear(animated: Bool) {
        let url = NSURL(string: "http://waterdata.usgs.gov/pr/nwis/current/?type=lake_m&group_key=NONE")
        var html = ""
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            (NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            var x:String = (NSString(data: data!, encoding: NSUTF8StringEncoding)) as! String
            //
            //            if let name = aDecoder.decodeObjectForKey(x) as? NSString {
            //                self.name = name as String
            //            } else {
            //                assert(false, "ERROR: could not decode")
            //                self.name = "ERROR"
            //            }
            
            var i:Int = 0
            var arrayI = 0
            
            
            if let doc = Kanna.HTML(html: x, encoding: NSUTF8StringEncoding) {
                print(doc)
                
                // Search for nodes by CSS
                var dictionary = [0:"",1:"",2:"",3:""]
                var inode = 0
                
                for link in doc.css("tr>td") {
                    if i >= 2{
                        var text:String? = link.text
                        dictionary[inode] = text
                        if  inode == 3{
                            self.myNewDictArray.append(dictionary)
                            inode = 0
                            arrayI++
                            
                        }
                        else{
                            inode++
                        }
                    }
                    i++
                }
            }
            
            for(var i:Int = 0; i <  self.myNewDictArray.count; i++){
                
                print(self.myNewDictArray[i][0])
                print(self.myNewDictArray[i][1])
                print(self.myNewDictArray[i][2])
                print(self.myNewDictArray[i][3])
                print("\n")
                
            }
//            self.embalsesTable.dataSource = self
//            self.embalsesTable.delegate = self
            
            //        self.tableView(embalsesTable, numberOfRowsInSection: self.myNewDictArray.count)
            self.embalsesTable.reloadData()
        }
        
        task.resume()
        
       


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        self.r
        return myNewDictArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableContent", forIndexPath: indexPath) as! EmbalsesTableViewCell

        let embalsesInfo = myNewDictArray[indexPath.row]

        cell.pueblo.text = "San Juan"
        cell.embalse.text = embalsesInfo[1]
        cell.fecha.text = embalsesInfo[2]
        cell.metros.text = embalsesInfo[3]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        self.performSegueWithIdentifier("detail_segue", sender: self)
        self.nextScreenRow = indexPath.row
                self.performSegueWithIdentifier("detail_segue", sender: self)


    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
//        if (segue.identifier == "detail_segue") {
//            let embalsesInfo = myNewDictArray[]

//            var destinationVC:DetailViewController = segue.destinationViewController

//
        
            var detailController = segue.destinationViewController as! DetailViewController;
            
            detailController.county = myNewDictArray[nextScreenRow][1]!
            detailController.date = myNewDictArray[nextScreenRow][2]!
            detailController.meters = myNewDictArray[nextScreenRow][3]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        print(detailController)
//    }
        
    }// end prepareForSegue

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

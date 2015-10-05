//
//  EmbalsesTableViewController.swift
//  Embalses
//
//  Created by Jorge Perez on 9/29/15.
//  Copyright © 2015 Jorge Perez. All rights reserved.
//

import UIKit
import Kanna

class EmbalsesTableViewController: UITableViewController, UIBarPositioningDelegate {
    
    var myNewDictArray:[Dictionary<Int, String>] = []
    
    var niveles:[Dictionary<String, [Double]>] = []

    var nextScreenRow:Int = 0
    
    @IBOutlet var embalsesTable: UITableView!
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);

        
        let url = NSURL(string: "http://waterdata.usgs.gov/pr/nwis/current/?type=lake_m&group_key=NONE")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)
            { (data, response, error) in
                (NSString(data: data!, encoding: NSUTF8StringEncoding))
                
                let x:String = (NSString(data: data!, encoding: NSUTF8StringEncoding)) as! String
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
                    var pueblos = ["Quebradillas","Isabela", "Adjuntas", "Lares", "Ututado", "Utuado", "Arecibo","Barranquitas","Orocovis", "Guayama", "Tota Alta", "Cidra","San Juan","Trujillo Alto", "Fajardo", "Naguabo", "Naguabo", "Patillas", "Guayama", "Coamo", "Villalba", "Juana Diaz","Ponce","Yauco", "Yauco", "Adjuntas","Adjuntas","Añasco"]
                    
                    var lagos = ["Lago Guajataca","Lago Regulador de Isabela", "Lago Gazas", "Lago Adjuntas", "Lago Vivi", "Lago Caonillas", "Lago Dos Bocas","Lago El Guineo","Lago de Matrullas", "Lago Carite", "Lago La Plata", "Lago de Cidra","Lago Las Curias","Lago Loiza (Carraizo)", "Lago Fajardo", "Lago Icacos", "Lago Blanco", "Lago Patillas", "Lago Melania", "Lago Coamo", "Lago Toa Vaca", "Lago Guayabal","Lago Cerrillos","Lago Lucchetti", "Lago Loco", "Lago Yahuecas","Lago Guayo","Lago Daguey"]
                    
                    for(var i:Int = 0; i <  self.myNewDictArray.count; i++)
                    {
                        self.myNewDictArray[i][0] = pueblos[i]
                        self.myNewDictArray[i][1] = lagos[i]
                    }
                    
                    self.niveles = [
                        ["Lago Loiza (Carraizo)":[41.14,39.50,38.5,36.5,30]],
                        ["Lago La Plata":[51,43,39,38,31]],
                        ["Lago de Cidra":[403.05,401.05,400.05,399.05,398.05]],
                        ["Lago Patillas":[67.07,66.16,64.33,60.52,59.45]],
                        ["Lago Toa Vaca":[161,152,145,139,133]],
                        ["Lago Carite":[544,542,539,537,537]],
                        ["Lago Blanco":[28.75,26.50,24.25,22.50,18]],
                        ["Lago Caonillas":[252,248,244,242,235]],
                        ["Lago Fajardo":[52.50,48.3,43.4,37.5,26]],
                        ["Lago Guajataca":[196.90,194,190,186,184]],
                        ["Lago Cerrillos":[173.40,160,155.50,149.40,137.20]]
                    ]
                }
                
                
                //            self.embalsesTable.dataSource = self
                //            self.embalsesTable.delegate = self
                
                //        self.tableView(embalsesTable, numberOfRowsInSection: self.myNewDictArray.count)
                dispatch_async(dispatch_get_main_queue(),
                    {
                        self.tableView.reloadData()
                });
        }
        
        
        
        task.resume()

        
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

        cell.pueblo.text = embalsesInfo[0]
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
        
            let detailController = segue.destinationViewController as! DetailViewController;
        
            if nextScreenRow <  niveles.count
            {
                detailController.niveles = niveles[nextScreenRow][myNewDictArray[nextScreenRow][1]!]
            }
            detailController.county = myNewDictArray[nextScreenRow][1]!
            detailController.date = myNewDictArray[nextScreenRow][2]!
            detailController.meters = myNewDictArray[nextScreenRow][3]!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

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

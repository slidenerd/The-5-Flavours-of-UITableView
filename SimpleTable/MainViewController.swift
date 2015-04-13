//
//  MainViewController.swift
//  SimpleTable
//
//  Created by Vivek Ramesh on 10/04/15.
//  Copyright (c) 2015 slidenerd. All rights reserved.
//

import UIKit
/**
Specify the 5 styles associated with a TableView
1) The user only sees text
2) The user sees an image on the left followed by text on the right
3) The user sees an image on the left followed by text on the right and subtext below the text
4) The user sees an image on the left followed by texy on the right and subtext in the same line at the end
5) The user sees text on the left and subtext on the right without any images
*/
enum Style {
    case Text, TextWithImage, AllInOneLine, AllInManyLines, TextWithSub;
}
class MainViewController: UIViewController ,  UITableViewDelegate, UITableViewDataSource{
    
    private let dwarves = ["Sleepy" , "Sneezy" , "Bashful" , "Happy" , "Doc" , "Grumpy" , "Dopey" , "Thorin" , "Dorin" , "Nori" , "Ori" , "Balin" , "Dwalin" , "Fili" , "Kili" , "Oin" , "Gloin" , "Bifur" , "Bofur" , "Bombur"]
    let tableIdentifier: String = "MyTable";
    
    @IBOutlet weak var tableView: UITableView!
    var style : Style = Style.Text;
    
    @IBAction func buttonPressed(sender: AnyObject) {
        let controller = UIAlertController(title: "Which Style?", message: "The table would love to hear your thoughts", preferredStyle: UIAlertControllerStyle.Alert);
        //Each time the user selects an action, the UITableView needs to be refreshed or more specifically needs its layout changed according to the new operation, update the style and ask the TableView to reload its data, a more efficient suggestion is also welcome
        let actionText = UIAlertAction(title: "Only Text", style: .Default) {
            (action: UIAlertAction!) -> () in
            self.style = Style.Text;
            self.tableView.reloadData();
        }
        let actionTextWithImage = UIAlertAction(title: "Text + Image", style: .Default) {
            (action: UIAlertAction!) -> () in
            self.style = Style.TextWithImage;
            self.tableView.reloadData();
        }
        let actionAllInOne = UIAlertAction(title: "All In One Line" , style: .Default) {
            (action: UIAlertAction!) -> () in
            self.style = Style.AllInOneLine;
           self.tableView.reloadData();
        }
        let actionAllInMany = UIAlertAction(title: "All In Two Lines", style: .Default) {
            (action: UIAlertAction!) -> () in
            self.style = Style.AllInManyLines;
            self.tableView.reloadData();
        }
        let actionTextWithSub = UIAlertAction(title: "Text + SubText", style: .Default) {
            (action: UIAlertAction!) -> () in
            self.style = Style.TextWithSub;
            self.tableView.reloadData();
        }
        controller.addAction(actionText);
        controller.addAction(actionTextWithImage);
        controller.addAction(actionAllInOne);
        controller.addAction(actionAllInMany);
        controller.addAction(actionTextWithSub);
        presentViewController(controller, animated: true) { () -> Void in
            //triggered when the user opens the controller
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // we can tell the table that all of its rows should have a given, fixed height. To do that, we set its rowHeight property
//        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count;
    }
    
    /**
    This method sets the indent level for each row based on its row number; so row 0 will have an indent level of 0, row 1 will have an indent level of 1, and so on.
    **/
//    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
//        return indexPath.row%4;
//    }
    
    /**
    This method is passed an indexPath that represents the item that’s about to be selected. Our code looks at which row is about to be selected and if it’s the first row, which is always index zero, then it returns nil, which indicates that no row should actually be selected. Otherwise, it returns the unmodified indexPath, which is how we indicate that it’s OK for the selection to proceed.
    **/
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil;
        }
//        else if (indexPath.row % 2 == 0){
//            //change the selection made by the user, its highly unlikely that you need to do this but in our case , if the user selects an item at an even position, we change it to an odd one and so on. use this with caution
//            return NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
//        }
        else{
            return indexPath;
        }
    }
    
    /**
    Triggered when the user hits select on one of the rows of the UITableView and selects an item
    **/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowValue = dwarves [indexPath.row];
        let message = "hey, guess what , you selected \(rowValue)";
        let controller = UIAlertController(title: "Row Selected", message: message, preferredStyle: UIAlertControllerStyle.Alert);
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil);
        controller.addAction(action);
        presentViewController(controller, animated: true, completion: nil);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableIdentifier) as? UITableViewCell
        if cell == nil {
            //this part comes into effect when you are trying to create a cell object for the very first time
            print("new cell \(style)")
        }
        else{
            //this part comes into effect when you are reusing an already created cell object
        }
        
        //This code isnt optimal since we are always trying to create a new object of cell , a better suggestion is always welcome here
        switch(style) {
        case Style.Text:
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: tableIdentifier);
        case Style.TextWithImage:
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: tableIdentifier);
            setImage(cell, indexPath: indexPath);
        case Style.AllInManyLines:
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: tableIdentifier);
            setImage(cell, indexPath: indexPath);
        case Style.AllInOneLine:
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: tableIdentifier);
            setImage(cell, indexPath: indexPath);
        case Style.TextWithSub:
            cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: tableIdentifier);
        }
        //regardless of the chosen style, we ll always need a primary label :)
         cell!.textLabel?.text = dwarves[indexPath.row]
//        cell!.textLabel!.font = UIFont.boldSystemFontOfSize(20)
        //Notice this is not an implicitly unwrapped optional, talking about how are have accessed the detailedTextLabel, the reason? pretty simple, if this was implicity unwrapped, its not available in certain styles such as Default, the app would crash in the Default style if you tried to access this value by implicitly unwrapping it
        cell?.detailTextLabel?.text = "I am at row number \(indexPath.row)";
        return cell!;
    }

    /**
    :param: cell would be the UITableViewCell instance on which we want to set an image
    :param: indexPath would refer to the current section whose row we want to access and update
    **/
    private func setImage(cell : UITableViewCell? , indexPath : NSIndexPath) {
        let image : UIImage?;
        //we wanna set images all having the same names like number_0, number_1 upto number_9
        //the best way to do this is to take the row number, take its modulus with 10 which ll return 0-9 and use these values in the file name with string interpolation and display the appropriate images
        switch (indexPath.row % 10) {
        case let n:
            //string interpolation with remainder after performing a modulus operation in the switch condition
            image = UIImage(named: "number_\(n)");
            //returns 85.33 on all devices
            println("image width \(image?.size.width) height \(image?.size.height)")
            //for new cells , as per observation, both the bounds and frame return 0 whereas for existing cells, they return 0.0 0.0 44.0 43.5 on all devices
            println("\(cell?.imageView?.frame) frame \(cell?.imageView?.bounds) bounds")
            //set the secondary text for the tableview using the detailTextLabel property , by default the secondary text comes right below the primary heading
        }
        cell?.imageView?.image = image;
    }
    
    /**
    If you need different rows to have different heights, you can implement the UITableViewDelegate’s tableView(_, heightForRowAtIndexPath:) method
    **/
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //for all even rows, let the row height be 80 points and for the rest let it be 40 points
        switch (indexPath.row % 4) {
        case 0:
            return 40;
        case 1:
            return 50;
        case 2:
            return 60;
    default:
            return 70;
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

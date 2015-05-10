//
//  CZDatePickerTableViewController.swift
//  Calendartest
//
//  Created by HuCharlie on 5/10/15.
//  Copyright (c) 2015 HuCharlie. All rights reserved.
//

import UIKit

class CZDatePickerTableViewController: UITableViewController {

    var selectedRowIndex:NSIndexPath? = nil
    var datePicked:String = "not yet"
    let dateFormatter:NSDateFormatter = NSDateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 3
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CZDatePickerTableViewCell = tableView.dequeueReusableCellWithIdentifier("selectDate", forIndexPath: indexPath) as! CZDatePickerTableViewCell

        cell.TitleLabel.text = "test"
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
        
        
        
//
        
        if selectedRowIndex != indexPath {
            
            selectedRowIndex = indexPath
            
            cell.TitleLabel.text = "select date"
            
            let doneBtn:UIButton = UIButton(frame: CGRectMake(200, 300, 200, 100))
         
            
            doneBtn.setTitle("Done", forState: UIControlState.Normal)
            doneBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            doneBtn.tag = indexPath.row
            doneBtn.addTarget(self, action: "doneBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(doneBtn)
            
            let datepicker:UIDatePicker = UIDatePicker(frame: CGRectMake(50, 100, 400, 200))
            datepicker.datePickerMode = UIDatePickerMode.Time
            datepicker.tag = indexPath.row
            datepicker.addTarget(self, action: "timepickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
            datePicked = dateFormatter.stringFromDate(datepicker.date)
            cell.addSubview(datepicker)

            
        }else{
            
            
            for subview in cell.subviews {

                if subview.isKindOfClass(UIButton) || subview.isKindOfClass(UIDatePicker){
                
                    subview.removeFromSuperview()
                }

            }
            
            cell.TitleLabel.text = datePicked
            
            selectedRowIndex = nil
            
            
            

            
            
        }
        
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
       
        
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (selectedRowIndex != nil)&&(selectedRowIndex!.row == indexPath.row ) {
            return 400
        }
        
        return 100
        
        
    }
    
   
    
    
    

}



extension CZDatePickerTableViewController {
    
    func doneBtnClicked(sender:UIButton!) {
        
        let indexPath:NSIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
      
        self.tableView.delegate?.tableView!(self.tableView, didSelectRowAtIndexPath: indexPath)
        
        cell.TitleLabel.text = datePicked
        
        
    }
    
    func timepickerChanged(sender:UIDatePicker) {
        
        
        dateFormatter.dateFormat = "MM-dd hh:mm"
        
        datePicked = dateFormatter.stringFromDate(sender.date)
        
        let indexPath:NSIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
        
        cell.TitleLabel.text = datePicked
        
    }
    
}


















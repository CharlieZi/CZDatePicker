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
    var datePicked:NSDate = NSDate()
    let dateFormatter:NSDateFormatter = NSDateFormatter()
    let cellIdentifier:NSArray = ["selectDate","selectTime"]
    
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
       
        return cellIdentifier.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CZDatePickerTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier[indexPath.row] as! String, forIndexPath: indexPath) as! CZDatePickerTableViewCell

        if cellIdentifier[indexPath.row] as! String == "selectDate" {
            cell.SetDateLabel.text = "select date"
        }else{
            cell.SetTimeLabel.text = "select time"
        }
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
        
        
        if (selectedRowIndex != nil) {
            let celltoClean:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(selectedRowIndex!)as! CZDatePickerTableViewCell
            for subview in celltoClean.subviews {
                if subview.isKindOfClass(UIButton) || subview.isKindOfClass(UIDatePicker){
                    subview.removeFromSuperview()
                }
            }
        } // remove subview of deselected row
        
        if selectedRowIndex != indexPath {
            
            selectedRowIndex = indexPath
            if cellIdentifier[indexPath.row] as! String == "selectDate" {
                cell.SetDateLabel.text = "select date"
                
            }else{
                cell.SetTimeLabel.text = "select time"
            }

            // subpickercell UI
            //button Done
            let doneBtn:UIButton = UIButton(frame: CGRectMake(200, 300, 200, 100))
            doneBtn.setTitle("Done", forState: UIControlState.Normal)
            doneBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            doneBtn.tag = indexPath.row
            doneBtn.alpha = 0
            doneBtn.addTarget(self, action: "doneBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(doneBtn)
            //button cancel
            let cancelBtn:UIButton = UIButton(frame: CGRectMake(0, 300, 200, 100))
            cancelBtn.setTitle("Cancel", forState: UIControlState.Normal)
            cancelBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            cancelBtn.tag = indexPath.row
            cancelBtn.alpha = 0
            cancelBtn.addTarget(self, action: "cancelBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(cancelBtn)
            //datepicker
            let datepicker:UIDatePicker = UIDatePicker(frame: CGRectMake(0, 100, 400, 200))
            datepicker.tag = indexPath.row
            datepicker.alpha = 0
            datepicker.addTarget(self, action: "timepickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
            if cellIdentifier[indexPath.row] as! String == "selectDate" {
                datepicker.datePickerMode = UIDatePickerMode.Date
            }else{
                datepicker.datePickerMode = UIDatePickerMode.Time
            }
            // animation
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                datepicker.alpha = 1.0
                doneBtn.alpha = 1.0
                cancelBtn.alpha = 1.0
            })
            cell.addSubview(datepicker)
            
        }else{
            
            
            for subview in cell.subviews {

                if subview.isKindOfClass(UIButton) || subview.isKindOfClass(UIDatePicker){
                
                    subview.removeFromSuperview()
                }

            }
            
            CellReuseLabeldefiner(cell, identifierArray: cellIdentifier, indexPath: indexPath, date: datePicked)
            
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
        
        CellReuseLabeldefiner(cell, identifierArray: cellIdentifier, indexPath: indexPath, date: datePicked)
        
    }
    
    func cancelBtnClicked(sender:UIButton) {
        
        let indexPath:NSIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
        
        self.tableView.delegate?.tableView!(self.tableView, didSelectRowAtIndexPath: indexPath)

    }
    
    func timepickerChanged(sender:UIDatePicker) {
        
        datePicked = sender.date
        
        let indexPath:NSIndexPath = NSIndexPath(forRow: sender.tag, inSection: 0)
        
        let cell:CZDatePickerTableViewCell = tableView.cellForRowAtIndexPath(indexPath)as! CZDatePickerTableViewCell
      
        CellReuseLabeldefiner(cell, identifierArray: cellIdentifier, indexPath: indexPath, date: datePicked)
        
    }
    
}

extension CZDatePickerTableViewController {
    
    
    func CellReuseLabeldefiner(cell:CZDatePickerTableViewCell,identifierArray:NSArray,indexPath:NSIndexPath,date:NSDate) -> Void {
        
        if identifierArray[indexPath.row] as! String == identifierArray.firstObject as! String {
            
            dateFormatter.dateFormat = "MM-dd"
            cell.SetDateLabel.text = dateFormatter.stringFromDate(date)
        }else{
            dateFormatter.dateFormat = "hh:mm"
            cell.SetTimeLabel.text = dateFormatter.stringFromDate(date)
        }
        
    }
    
}












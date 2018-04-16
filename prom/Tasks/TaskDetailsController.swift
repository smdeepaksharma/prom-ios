//
//  TaskDetailsController.swift
//  prom
//
//  Created by Deepak Sharma S M on 4/15/18.
//  Copyright © 2018 Deepak Sharma S M. All rights reserved.
//

import UIKit

class TaskDetailsController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var estimate: UITextField!
    @IBOutlet weak var taskDueDate: UITextField!
    var picker = UIDatePicker()
    var estimatePicker = UIPickerView()
    
    let estimatePoints = ["0 points", "1 point", "2 points", "3 points", "5 points"]
    
    var taskTitle: String?
    var taskDescription: String?
    var taskDue: String?
    var taskEstimate: String?
    var collaborators: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        createEstimatePointsPicker()
        estimatePicker.dataSource = self
        estimatePicker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return estimatePoints.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return estimatePoints[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        estimate.text = estimatePoints[row]
    }
    
    func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let dueDateDone = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        dueDateDone.tag = 1
        let removeDueDate = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(removePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: #selector(removePressed))
        removeDueDate.tag = 2
        toolBar.setItems([dueDateDone, space, removeDueDate], animated: true)
        taskDueDate.inputAccessoryView = toolBar
        taskDueDate.inputView = picker
        picker.datePickerMode = .date
    }
    
    func createEstimatePointsPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onEstimateMade))
        toolBar.setItems([done], animated: true)
        estimate.inputAccessoryView = toolBar
        estimate.inputView = estimatePicker
    }
    
    @objc func onEstimateMade() {
        self.view.endEditing(true)
    }
    
    
    @objc func donePressed() {
        let formatter = DateFormatter();
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: picker.date)
        taskDueDate.text = "Due on \(dateString)"
        self.view.endEditing(true)
    }
    
    @objc func removePressed() {
        taskDueDate.text = nil
        self.view.endEditing(true)
    }

    @IBAction func pickMembers(_ sender: Any) {
        performSegue(withIdentifier: "pickMembers", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    

}

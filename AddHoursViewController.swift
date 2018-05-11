//
//  AddHoursViewController.swift
//  Volunteered Here
//
//  Created by Dad on 5/4/18.
//  Copyright © 2018 Jeff Kirshenbaum. All rights reserved.
//

import UIKit
import Firebase

class AddHoursViewController: UIViewController {

    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var hoursTextField: UITextField!
    @IBOutlet var orgTextField: UITextField!
    @IBOutlet var orgEmailTextField: UITextField!
    @IBOutlet var workPerformedTextField: UITextField!
    
    let picker = UIDatePicker()
    
    var event:[Event]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let eventsDB = FIRDatabase.database().reference().child("Events")
        
        let eventsDictionary = ["Date": dateTextField.text!, "Hours": hoursTextField.text!, "Organization": orgTextField.text!, "Email": orgEmailTextField.text!, "Description": workPerformedTextField.text!, "Verified": "false"]
        eventsDB.childByAutoId().setValue(eventsDictionary) {
            (error, ref) in
            
            if error != nil {
                print(error)
            } else {
                print("Event saved successfully!")
                self.performSegue(withIdentifier: "volunteerTracking", sender: self)
            }
        }
        
        
    }
    
    func createDatePicker () {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = picker
        
        picker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        dateTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }

}

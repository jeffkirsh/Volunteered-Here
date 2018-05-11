//
//  ViewController.swift
//  Volunteered Here
//
//  Created by Jeff Kirshenbaum on 05/08/2018.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    var eventArray : [Events] = [Events]()
    
    // We've pre-linked the IBOutlets
//    @IBOutlet var heightConstraint: NSLayoutConstraint!
//    @IBOutlet var sendButton: UIButton!
//    @IBOutlet var eventTextfield: UITextField!
    @IBOutlet var eventTableView: UITableView!
    
    var topButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(UINib(nibName: "CustomReportCell", bundle: nil) , forCellReuseIdentifier: "customReportCell")
        eventTableView.estimatedRowHeight = 50
        eventTableView.rowHeight = UITableViewAutomaticDimension
        
        configureTableView()
        
        
        retrieveMessages()
        
        eventTableView.separatorStyle = .none
        
    }
    
    
    
    //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customReportCell", for: indexPath) as! CustomReportCell
        
        cell.reportDate.text = eventArray[indexPath.row].date
        cell.reportDate.numberOfLines = 0
        cell.reportDate.textAlignment = .justified
        
        cell.reportDesc.text = eventArray[indexPath.row].description
        cell.reportDesc.numberOfLines = 0
        cell.reportDesc.textAlignment = .justified
        
        cell.reportHours.text = eventArray[indexPath.row].hours
        cell.reportHours.numberOfLines = 0
        cell.reportHours.textAlignment = .justified
        
        cell.reportOrg.text = eventArray[indexPath.row].organization
        cell.reportOrg.numberOfLines = 0
        cell.reportOrg.textAlignment = .justified
        
        cell.reportOrgEmail.text = eventArray[indexPath.row].orgEmail
        cell.reportOrgEmail.numberOfLines = 0
        cell.reportOrgEmail.textAlignment = .justified
        
        if eventArray[indexPath.row].verified == "true" {
          cell.reportVerified.image = UIImage(named: "Anselmus_Green_Checkmark_And_Red_Minus_clip_art_small")
        }

//        cell.reportVerified.text = eventArray[indexPath.row].verified
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        eventTableView.rowHeight = UITableViewAutomaticDimension
        eventTableView.estimatedRowHeight = 120.0
        
        
    }
    
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve Messages from Firebase
    
    
//    @IBAction func sendPressed(_ sender: AnyObject) {
//
//        messageTextfield.endEditing(true)
//        messageTextfield.isEnabled = false
//        sendButton.isEnabled = false
//
//        let messagesDB = Database.database().reference().child("Messages")
//
//        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
//                                 "MessageBody": messageTextfield.text!]
//
//        messagesDB.childByAutoId().setValue(messageDictionary) {
//            (error, reference) in
//
//            if error != nil {
//                print(error!)
//            }
//            else {
//                print("Message saved successfully!")
//            }
//
//            self.messageTextfield.isEnabled = true
//            self.sendButton.isEnabled = true
//            self.messageTextfield.text = ""
//
//
//        }
//
//
//    }
    
    
    func retrieveMessages() {
        
        let eventDB = FIRDatabase.database().reference().child("Events")
        
        eventDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let date = snapshotValue["Date"]!
            let hours = snapshotValue["Hours"]!
            let organization = snapshotValue["Organization"]!
            let email = snapshotValue["Email"]!
            let description = snapshotValue["Description"]!
            let verified = snapshotValue["Verified"]!
            
            let events = Events()
            events.date = date
            events.description = description
            events.hours = hours
            events.orgEmail = email
            events.organization = organization
            events.verified = verified
            
            self.eventArray.append(events)
            
            
            self.configureTableView()
            self.eventTableView.reloadData()
            
        }
        
    }
    
    
    ////////////////////////////////////////////////
    
    //MARK - Log Out Method
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do {
            try FIRAuth.auth()?.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("error: there was a problem logging out")
        }
        
    }
    
    
    
}

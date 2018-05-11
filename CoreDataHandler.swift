//
//  CoreDataHandler.swift
//  Volunteered Here
//
//  Created by Dad on 5/7/18.
//  Copyright © 2018 Jeff Kirshenbaum. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }

    class func saveObject(date:String, hours:String, org:String, orgEmail:String, desc:String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(date, forKey: "date")
        managedObject.setValue(hours, forKey: "hours")
        managedObject.setValue(org, forKey: "organization")
        managedObject.setValue(orgEmail, forKey: "orgEmail")
        managedObject.setValue(desc, forKey: "work")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func fetchObject() -> [Event]? {
        let context = getContext()
        var event:[Event]? = nil
        do {
            event = try context.fetch(Event.fetchRequest())
            return event
        } catch {
            return event
        }
    }
    
}

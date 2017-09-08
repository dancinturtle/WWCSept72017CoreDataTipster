//
//  CoreDataManager.swift
//  tipster
//
//  Created by Amy Giver on 9/7/17.
//  Copyright © 2017 Anna Propas. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject {
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func saveEvent(total: Double, tipPercent: Int) -> Bool {
        let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: moc) as! Expense
        newEvent.total = total
        newEvent.date = Date() as NSDate
        newEvent.tipPercent = Int16(tipPercent)
        if moc.hasChanges {
            do {
                try moc.save()
                return true
            }
            catch {
                print("Error with saving \(error)")
                return false
            }
        }
        return false
    }
    
    public func fetchEvents() -> [Expense]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        do {
            let results = try moc.fetch(request)
            let expenses = results as! [Expense]
            return expenses
        }
        catch {
            print("We failed trying to fetch \(error)")
            return nil
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

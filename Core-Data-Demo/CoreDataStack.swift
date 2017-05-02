//
//  CoreDataStack.swift
//  Core-Data-Demo
//
//  Created by Jennifer A Sipila on 4/30/17.
//  Copyright © 2017 Jennifer A Sipila. All rights reserved.
//

import UIKit
import CoreData

// MAKE SURE YOUR CORE DATA STACK FILE LOOKS LIKE THIS (except where noted).

class CoreDataStack: NSObject {
    
    static let shared = CoreDataStack()
    
    private static let name = "TaskModel" //MAKE SURE this is the same name as your data model.
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.name)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Error: \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch  {
                let nserror = error as NSError
                print("Unresolved error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}





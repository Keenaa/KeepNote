//
//  DataManager.swift
//  KeepNote
//
//  Created by guillaume chieb bouares on 03/12/2016.
//  Copyright © 2016 com.github.keena.shemana. All rights reserved.
//

import Foundation
import CoreData

class DataManager: NSObject {
    
    public static let sharedInstance = DataManager()
    
    public var objectContext: NSManagedObjectContext?
    
    private override init(){
        if let modelURL = Bundle.main.url(forResource: "KeepNote", withExtension: "momd"){
            if let model = NSManagedObjectModel(contentsOf: modelURL){
                let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                _ = try? persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: FileManager.documentURL(childpath: "keepnote.db"), options: nil)
                let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                context.persistentStoreCoordinator = persistentStoreCoordinator
                self.objectContext = context
            }
            
        }
        
    }
    
}

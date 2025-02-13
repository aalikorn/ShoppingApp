//
//  CoreDataStack.swift
//  ShoppingApp
//
//  Created by Даша Николаева on 13.02.2025.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingApp")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private init() {}
}

//
//  Persistence.swift
//  SaDeBusinessCardScanner
//
//  Created by Ayush Narwal on 23/09/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        for i in 0..<10 {
            let card = Card(context: viewContext)
            card.name_ = "name " + String(i)
            card.company_ = "company " + String(i)
            card.jobTitle_ = "jobtitle" + String(i)
            card.email_ = String(i) + "@email.com"
            card.phone_ = String(i)+String(i)+String(i)+String(i)+String(i)+String(i)
            card.website_ = "www." + String(i) + ".com"
            card.address_ = "address" + String(i)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()


    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SaDeBusinessCardScanner")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
                print("can't save core data to context")
            }
        }
    }
    
    func delete(card: Card) {
        let context = container.viewContext
        
        context.delete(card)
        do {
            try context.save()
        } catch {
            // Show some error here
            print("can't delete core data entity from context")
        }
        
    }
}

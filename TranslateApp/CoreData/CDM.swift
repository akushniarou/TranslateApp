
//import Foundation
//import CoreData
//
//var persistentContainer: NSPersistentContainer = {
//    let container = NSPersistentContainer(name: "TranslateApp")
//    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//        if let error = error as NSError? {
//            fatalError("Unresolved error \(error), \(error.userInfo)")
//        }
//    })
//    return container
//}()
//
//var context: NSManagedObjectContext = {
//    return persistentContainer.viewContext
//}()
//
//func saveContext () {
//    if context.hasChanges {
//        do {
//            try context.save()
//        } catch {
//            context.rollback()
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//    }
//}
//
//let fetchRequest: NSFetchRequest<CoreDataTask> = CoreDataTask.fetchRequest()
//
//

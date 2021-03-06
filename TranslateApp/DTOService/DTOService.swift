
import UIKit
import CoreData

protocol DTOProcessing {
    func getStoredTasks() -> [Task]
    func saveTask(task: Task)
    func deleteTask(task: Task)
}

class DTOService: DTOProcessing {
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    private let image = UIImage(named: "noData")?.pngData()
    
    init(){
        container = NSPersistentContainer(name: "TranslateApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
    }
    
    public func getStoredTasks() -> [Task] {
        var result: [Task] = []
        let fetchRequest: NSFetchRequest<CoreDataTask> = CoreDataTask.fetchRequest()
        for task in try! context.fetch(fetchRequest) {
            if let pathString = task.picture {
                let imageFromDB = getImageData(with: pathString)
                result.append(Task(enteredWord: task.enteredWord ?? "", originalLanguage: task.originalLanguage ?? "", targetLanguage: task.targetLanguage ?? "", translatedWord: task.translatedWord ?? "", picture: imageFromDB ?? image!))
            }
        }
        return result
    }
    
    public func saveTask(task: Task) {
        let nsTask = CoreDataTask(context: context)
        let date = Int(Date().timeIntervalSince1970)
        let name = "\(date).png"
        nsTask.enteredWord = task.enteredWord
        nsTask.originalLanguage = task.originalLanguage
        if let pictureURI = saveImage(with: name, data: task.picture) {
            nsTask.picture = pictureURI
        } else {
            print("can't save image")
        }
        nsTask.targetLanguage = task.targetLanguage
        nsTask.translatedWord = task.translatedWord
        
        do {
            try context.save()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    public func deleteTask(task: Task) {
        let fetchRequest: NSFetchRequest<CoreDataTask> = CoreDataTask.fetchRequest()
        let tasks = try! context.fetch(fetchRequest)
        
        if let coreDataTask = tasks.first(where: { (item) -> Bool in
            return task.isEqual(to: item)
        }) {
            context.delete(coreDataTask)
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

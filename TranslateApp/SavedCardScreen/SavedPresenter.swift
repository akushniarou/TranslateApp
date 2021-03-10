
import Foundation

protocol SavedCardPresenter{
    init()
    func addView(view: SaveCardView)
    func getObjectsCount() -> Int
    func removeCard(row: Int)
    func getTaskByRow(row: Int) -> Task
}

class SavedPresenter: SavedCardPresenter {

    private let storeService = DTOService()
    
    private var savedCards = [String]()
    private var tasks = [Task]()
    
    private weak var view: SaveCardView?
    
    internal func addView(view: SaveCardView) {
        self.view = view
    }
    
    required init() {
        self.tasks = storeService.getStoredTasks()
    }
    
    internal func removeCard(row: Int) {
        storeService.deleteTask(task: tasks[row])
        tasks.remove(at: row)
    }
    
    internal func getObjectsCount() -> Int {
        return tasks.count
    }
    
    internal func getTaskByRow(row: Int) -> Task {
        return tasks[row]
    }
}

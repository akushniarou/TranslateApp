
import Foundation

protocol SavedCardPresenter{
    init()
    func addView(view: SaveCardView)
    func addExistingCards(tasks: [Task])
    func getObjects() -> [Task]
    func removeCard(card: Task)
}

class SavedPresenter: SavedCardPresenter {

    private let storeService = DTOService()
    internal let savedCard = SavedCardCell()
    internal var savedCards = [String]()
    
    private weak var view: SaveCardView?
    
    internal func addView(view: SaveCardView) {
        self.view = view
    }
    
    required init() {
    }
    
    internal func addExistingCards(tasks: [Task]) {
        
    }
    
    internal func getObjects() -> [Task] {
        let objects = storeService.getStoredTasks()
        return objects
    }
    
    internal func removeCard(card: Task) {
        storeService.deleteTask(task: card)
    }
}

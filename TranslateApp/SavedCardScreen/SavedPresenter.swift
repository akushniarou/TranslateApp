
import Foundation

protocol SavedCardPresenter{
    init()
    func addView(view: SaveCardView)
    func addExistingCards(tasks: [Task])
    func getObjects() -> [Task]
}

class SavedPresenter: SavedCardPresenter {

    internal let savedCard = SavedCardCell()
    
    private weak var view: SaveCardView?
    
    internal var savedCards = [String]()
    
    internal func addView(view: SaveCardView) {
        self.view = view
    }
    
    required init() {
    }
    
    internal func addExistingCards(tasks: [Task]) {
        
    }
    
    internal func getObjects() -> [Task] {
        let objects = try! context.fetch(fetchRequest)
        return objects
    }
}


import Foundation

protocol SavedCardPresenter{
    init()
    func addView(view: SaveCardView)
}

class SavedPresenter: SavedCardPresenter {
    
    private weak var view: SaveCardView?
    
    internal var savedCards = [String]()
    
    internal func addView(view: SaveCardView) {
        self.view = view
    }
    
    required init() {
    }
}
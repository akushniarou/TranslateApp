
import Foundation

protocol DetailedViewPresenter{
    init()
    func addView(view: DetailedView)
}

class DetailedPresenter: DetailedViewPresenter{

    private weak var view: DetailedView?
    
    internal func addView(view: DetailedView) {
        self.view = view
    }
    
    required init() {
    }
}

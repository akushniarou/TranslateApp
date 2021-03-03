
import Foundation

protocol DetailedViewPresenter{
    init()
    func addView(view: DetailedView)
    func saveTask()
}

class DetailedPresenter: DetailedViewPresenter{
    
    let storeService = DTOService()

    private weak var view: DetailedView?
    
    internal func addView(view: DetailedView) {
        self.view = view
    }
    
    required init() {
    }
    
    internal func saveTask() {
        let enteredWord = (view?.getOriginalWord())!
        let originalLanguage = (view?.getOriginalLanguage())!
        let image = (view?.getTranslationImage())!
        let targetLanguage = (view?.getTargetLanguage())!
        let transWord = (view?.getTranslatedWord())!
        let task = Task(enteredWord: enteredWord, originalLanguage: originalLanguage, targetLanguage: targetLanguage, translatedWord: transWord, picture: image)
        
        storeService.saveTask(task: task)
    }
}

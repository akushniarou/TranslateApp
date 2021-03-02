
import Foundation

protocol DetailedViewPresenter{
    init()
    func addView(view: DetailedView)
    func saveTask()
}

class DetailedPresenter: DetailedViewPresenter{

    private weak var view: DetailedView?
    
    internal func addView(view: DetailedView) {
        self.view = view
    }
    
    required init() {
    }
    
    internal func saveTask() {
        let obj = CoreDataTask(context: context)
        obj.enteredWord = view?.getOriginalWord()
        obj.originalLanguage = view?.getOriginalLanguage()
        obj.picture = view?.getTranslationImage()
        obj.targetLanguage = view?.getTargetLanguage()
        obj.translatedWord = view?.getTranslatedWord()
        saveContext()
    }
}

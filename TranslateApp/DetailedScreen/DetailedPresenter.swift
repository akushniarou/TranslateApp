
import Foundation

protocol DetailedViewPresenter{
    var translatedWordFromTable: TranslateResult! { get }
    func setTranslatedWordFromTable(tr: TranslateResult)
    func addView(view: DetailedView)
    func saveTask()
    func setCellColumns()
}

class DetailedPresenter: DetailedViewPresenter{
    
    internal var translatedWordFromTable: TranslateResult!
    
    private lazy var storeService = DTOService()

    private weak var view: DetailedView?
    
    internal func addView(view: DetailedView) {
        self.view = view
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
//MARK: - delegate methods
extension DetailedPresenter {
    func setTranslatedWordFromTable(tr: TranslateResult) {
        self.translatedWordFromTable = tr
    }
    
    internal func setCellColumns() {
        view?.originalLanguage.text = translatedWordFromTable?.fromLanguage.title
        view?.targetLanguage.text = translatedWordFromTable?.translateLanguage.title
        view?.originalWord.text = translatedWordFromTable?.translated
        view?.translatedWord.text = translatedWordFromTable?.result
    }
}

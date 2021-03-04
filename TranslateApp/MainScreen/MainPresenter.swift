
import Foundation

protocol MainViewPresenter {
    
    var selectedCellContent: TranslateResult? { get }
    func addView(view: MainView)
    func getTranslation()
    func getAllLanguages() -> Array<String>
    func getTranslationData() -> Array<TranslateResult>
    func getTargetLanguage() -> String
    func getOriginalLanguage() -> String
    func setOriginal(language: String)
    func setTarget(language: String)
    func setSelected(index: Int)
    func getNumberOfTranslations() -> Int
}

class MainPresenter: MainViewPresenter {
    
    internal enum State {
        case normal
        case loading
        case error(String)
    }
    
    private(set) var selectedCellContent: TranslateResult?
    private var translationData = [TranslateResult]()
    private var translateFrom = Language.english
    private var translateTo = Language.english
    
    private var translationRequest = TranslateRequest()
    private weak var view: MainView?
    private var state: State = .normal {
        didSet {
            self.view?.didUpdateState(state)
        }
    }
    
    func setSelected(index: Int) {
        selectedCellContent = getTranslationData()[index]
    }
    
    //MARK: - MainViewPresenter protocol
    internal func getTargetLanguage() -> String {
        return translateTo.title
    }
    
    internal func getOriginalLanguage() -> String {
        return translateFrom.title
    }
    
    internal func addView(view: MainView) {
        self.view = view
    }
    
    internal func getTranslation() {
        guard let translatedWord = view?.getTextForTranslation(),
              !translatedWord.isEmpty
        else { return }
        
        translationData.removeAll()
        view?.reloadData()
        
        self.state = .loading
        translationRequest.fetchTranslate(
            from: translateFrom,
            to: translateTo,
            data: translatedWord
        ) { [weak self] translationResult in
            self?.addTranslated(word: translationResult)
            self?.state = .normal
        }
    }
    
    internal func getAllLanguages() -> Array<String> {
        return Language.allCases.map{$0.title}
    }
    
    internal func setOriginal(language: String) {
        guard let language = Language.init(rawValue: language) else {
            return
        }
        translateFrom = language
    }
    
    internal func setTarget(language: String) {
        guard let language = Language.init(rawValue: language) else {
            return
        }
        translateTo = language
    }
    
    internal func getTranslationData() -> Array<TranslateResult> {
        return translationData
    }
    
    private func addTranslated(word: TranslateResult) {
        translationData.append(word)
        DispatchQueue.main.async{
            self.view?.reloadData()
        }
    }
    
    func getNumberOfTranslations() -> Int {
        return translationData.count
    }
}


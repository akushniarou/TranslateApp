
import Foundation

/*
 языкПервода
 языкОригинала
 слово
 пеервод
 
 
 БД
 языкПервода
 языкОригинала
 слово
 пеервод
 имяИзображения
 */

protocol MainViewPresenter {
    
    init()
    func addView(view: MainView)
    func getTranslation()
    func getAllLanguages() -> Array<String>
    func getTranslationData() -> Array<TranslateResult>
    func getTargetLanguage() -> String
    func getOriginalLanguage() -> String
    func setOriginal(language: String)
    func setTarget(language: String)
    func getContextData()
}

class MainPresenter: MainViewPresenter {
    
    required init() {
        
    }

    internal enum State {
        case normal
        case loading
        case error(String)
    }
        
    private var translationData = [TranslateResult]()
    private var translateFrom = Language.english
    private var translateTo = Language.english

    //    private let translateService: [TranslateService]!
    private var translationRequest = TranslateRequest()
    private weak var view: MainView?
    private var state: State = .normal {
        didSet {
            self.view?.didUpdateState(state)
        }
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
            
            DispatchQueue.main.async {
                self?.addTranslated(word: translationResult)
                self?.state = .normal
            }
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
    
    internal func getContextData() {
        
    }
    
    private func addTranslated(word: TranslateResult) {
        translationData.append(word)
        view?.reloadData()
    }
}


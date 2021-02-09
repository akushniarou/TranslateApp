
import Foundation

protocol MainViewPresenter {
    init()
    func addView(view: MainView)
    func getTranslation()
    func getLanguages() -> Array<String>
    func getArrayOfTranslatedWords() -> Array<String>
    func getSelectedValueInPickerViewTo() -> String
    func getSelectedValueInPickerViewFrom() -> String
    func setPickerFromValue(value: String)
    func setPickerToValue(value: String)
}

internal enum Language: String, CaseIterable {
    
    static let initialLanguage = Language.english
    
    case english = "english"
    case russian = "russian"
    case spanish = "spanish"
    case italian = "italian"
    case german = "german"
    case french = "french"
    case portuguese = "portuguese"
    case arabic = "arabic"
    case polish = "polish"
    
    var code: String {
        return rawValue
    }
    
    var locale: String {
        switch self {
        case .english:
            return "en_GB"
        case .russian:
            return "ru_RU"
        case .spanish:
            return "es_ES"
        case .italian:
            return "it_IT"
        case.german:
            return "de_DE"
        case .french:
            return "fr_FR"
        case .portuguese:
            return "pt_BR"
        case .arabic:
            return "ar_DZ"
        case.polish:
            return "pl_PL"
        }
    }
}

class MainPresenter: MainViewPresenter {
    func getSelectedValueInPickerViewTo() -> String {
        return selectedValueInPickerViewTo
    }
    
    func getSelectedValueInPickerViewFrom() -> String {
        return selectedValueInPickerViewFrom
    }
    
    
    
    private var arrayOfTranslatedWords = [String]()
    private var translateFrom = Language.english
    private var translateTo = Language.english
    internal var languages = [String]()
    private var selectedValueInPickerViewTo: String = Language.english.code
    private var selectedValueInPickerViewFrom: String = Language.english.code
    
    
    //    private let translateService: [TranslateService]!
    private var translationRequest = TranslateRequest()
    private weak var view: MainView?
    private var state: State = .normal {
        didSet {
            self.view?.didUpdateState(state)
        }
    }
    
    enum State {
        case normal
        case loading
        case error(String)
    }
    
    internal func addView(view: MainView) {
        self.view = view
    }
    
    required init () {
        for lang in Language.allCases {
            languages.append(lang.code)
        }
    }
    
    internal func getTranslation() {
        arrayOfTranslatedWords.removeAll()
        setTranslationDestination()
        view?.reloadData()
        
        guard let translatedWord = view?.getTextForTranslation(), translatedWord.count != 0 else { return }
        self.state = .loading
        translationRequest.fetchTranslate(from: translateFrom, to: translateTo, data: translatedWord) { translationResult in
            DispatchQueue.main.async {
                self.setWordsToTranslationArray(word: translationResult.result)
                self.state = .normal
            }
        }
    }
    
    internal func setTranslationDestination() {
        for lang in Language.allCases {
            if lang.code == getPickerFromValue().code {
                translateFrom = getPickerFromValue()
            }
            if lang.code == getPickerToValue().code {
                translateTo = getPickerToValue()
            }
        }
    }
    
    func getLanguages() -> Array<String> {
        return languages
    }
    
    internal func getPickerFromValue() -> Language {
        return Language.init(rawValue: (selectedValueInPickerViewFrom))!
    }
    
    internal func getPickerToValue() -> Language {
        return Language.init(rawValue: (selectedValueInPickerViewTo))!
    }
    
    internal func setPickerFromValue(value: String) {
        selectedValueInPickerViewFrom = value
    }
    
    internal func setPickerToValue(value: String) {
        selectedValueInPickerViewTo = value
    }
    
    internal func getArrayOfTranslatedWords() -> Array<String> {
        return arrayOfTranslatedWords
    }
    
    internal func setWordsToTranslationArray(word: String) {
        arrayOfTranslatedWords = [word.capitalized]
        view?.getTableView().reloadData()
    }
}


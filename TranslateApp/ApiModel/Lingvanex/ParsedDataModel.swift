
import Foundation

struct TranslateResult {
    let fromLanguage: MainPresenter.Language
    let translated: String
    let translateLanguage: MainPresenter.Language
    let result: String
    
    let anotherTranslated: [String]?
}

struct ParsedData {
    let result: String
    
    init?(data: DataForParsing){
        result = data.result
    }
}

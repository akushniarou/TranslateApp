
import Foundation

struct TranslateResult {
    let fromLanguage: Language
    let translated: String
    let translateLanguage: Language
    let result: String
    
    let anotherTranslated: [String]?
}

struct ParsedData {
    let result: String
    
    init?(data: DataForParsing){
        result = data.result
    }
}

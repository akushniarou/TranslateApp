
import Foundation

extension MainPresenter {
    
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
        
        var title: String {
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
}


import Foundation

struct Task {
    let enteredWord: String
    let originalLanguage: String
    let targetLanguage: String
    let translatedWord: String
    let picture: Data
    
    func isEqual(to task: CoreDataTask) -> Bool {
        return self.enteredWord == task.enteredWord &&
            self.originalLanguage == task.originalLanguage &&
            self.targetLanguage == task.targetLanguage &&
            self.translatedWord == task.translatedWord
    }
}

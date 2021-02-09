
import Foundation


protocol TranslateService {
    func fetchTranslate(word: String, from: Language, to: Language, completionHandler: @escaping (TranslateResult) -> Void)
}

class TranslateRequest {
    let dispatchGroup = DispatchGroup()
    var translateResult = [TranslateResult]()
    
    func appendResult(result: TranslateResult) {
        translateResult.append(result)
    }
    
    func fetchTranslate(from: Language, to: Language, data: String, completionHandler: @escaping (TranslateResult) -> Void) {
        dispatchGroup.enter()
        translateResult.removeAll()
        let ldto = LingvanexDTO()
        ldto.fetchTranslate(word: data, from: from, to: to, completionHandler: { [self] result in
            self.appendResult(result: result)
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: .main) {
        print(self.translateResult.count)
        completionHandler(self.translateResult[0])
        }
    }
}

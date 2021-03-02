
import Foundation


protocol TranslateService {
    func fetchTranslate(word: String, from: MainPresenter.Language, to: MainPresenter.Language, completionHandler: @escaping (TranslateResult) -> Void)
}

class TranslateRequest {
    let dispatchGroup = DispatchGroup()
    var translateResult = [TranslateResult]()
    
    func appendResult(result: TranslateResult) {
        translateResult.append(result)
    }
    
    func fetchTranslate(from: MainPresenter.Language, to: MainPresenter.Language, data: String, completionHandler: @escaping (TranslateResult) -> Void) {
        let ldto = LingvanexDTO()
        let ldto2 = LingvanexDTO2()
        let ldto3 = LingvanexDTO3()
        let ldto4 = LingvanexDTO4()
    
        translateResult.removeAll()
        
        dispatchGroup.enter()
        ldto.fetchTranslate(word: data, from: from, to: to, completionHandler: { [weak self] result in
            completionHandler(result)
            self?.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ldto2.fetchTranslate(word: data, from: from, to: to, completionHandler: { [weak self] result in
            completionHandler(result)
            self?.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ldto3.fetchTranslate(word: data, from: from, to: to, completionHandler: { [weak self] result in
            completionHandler(result)
            self?.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        ldto4.fetchTranslate(word: data, from: from, to: to, completionHandler: { [weak self] result in
            completionHandler(result)
            self?.dispatchGroup.leave()
        })
    }
}

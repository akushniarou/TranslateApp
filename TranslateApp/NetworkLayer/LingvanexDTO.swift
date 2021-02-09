
import Foundation

struct LingvanexDTO: TranslateService{
    
    private let apiUrl = lingvanexUrlString
    private let apiKey = lingvanexApiKey
    
    func fetchTranslate(word: String, from: Language, to: Language, completionHandler: @escaping (TranslateResult) -> Void) {
        
        let uploadedData = UploadData(from: from.locale, to: to.locale, data: word, platform: "api")
        
        do {
            let jsonData = try JSONEncoder().encode(uploadedData)
            let urlString = apiUrl
            let authorizationToken = apiKey
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(authorizationToken, forHTTPHeaderField: "Authorization")
            request.httpBody = jsonData
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                guard let data = data, let fetchedData = parseJson(withData: data) else {return}
                let translateResult = TranslateResult(fromLanguage: from,
                                                      translated: word,
                                                      translateLanguage: to,
                                                      result: fetchedData.result,
                                                      anotherTranslated: nil)
                completionHandler(translateResult)
            }
            
            task.resume()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
}


import Foundation

func parseJson(withData data: Data) -> ParsedData? {
    let decoder = JSONDecoder()
    do {
        let receivedData = try decoder.decode(DataForParsing.self, from: data)
        guard let fetchedData = ParsedData(data: receivedData) else { return nil }
        return fetchedData
    } catch let error as NSError {
        print(error.localizedDescription)
    }
    return nil
}

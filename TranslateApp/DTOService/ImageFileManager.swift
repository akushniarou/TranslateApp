
import UIKit

func saveImage(with name: String, data: Data) -> String? {
    let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    guard let imagesPath = documentsPath.appendingPathComponent("images") else {return nil}
    
    if !FileManager.default.fileExists(atPath: imagesPath.path) {
        if !createDirectory() {
            return nil
        }
    }
    let imagePath = imagesPath.appendingPathComponent(name)
    
    do {
        try data.write(to: imagePath)
        return name
    } catch let error as NSError{
        print("Unable save file.", error)
        return nil
    }
}

//MARK: - Create directory
func createDirectory() -> Bool {
    let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    guard let imagesPath = documentsPath.appendingPathComponent("images") else {return false}
    print(imagesPath)
    
    do{
        try FileManager.default.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
        return true
        
    }catch let error as NSError{
        print("Unable to create directory",error)
        return false
    }
}

func getImageData( with name: String) -> Data? {
    let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    guard let imagesPath = documentsPath.appendingPathComponent("images") else {return nil}
    let imagePath = imagesPath.appendingPathComponent(name)
    let image = UIImage(contentsOfFile: imagePath.path)
    return image?.pngData()
}

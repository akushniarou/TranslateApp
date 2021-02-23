
import UIKit

protocol DetailedView: class {
    func getOriginalLanguage() -> String?
    func getTargetLanguage() -> String?
    func getOriginalWord() -> String?
    func getTranslatedWord() -> String?
    func getTranslationImage() -> Data?
}

class DetailedViewController: UIViewController {
    
    var translatedWordFromTable: TranslateResult?
    
    @IBOutlet private weak var originalLanguage: UILabel!
    @IBOutlet private weak var targetLanguage: UILabel!
    @IBOutlet private weak var originalWord: UILabel!
    @IBOutlet private weak var translatedWord: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var saveButon: UIButton!
    
    private var translationImage: UIImage? {
        didSet {
            image.backgroundColor = .none
            image.image = translationImage
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            saveButon.isHidden = translationImage == nil
        }
    }
    private var presenter: DetailedViewPresenter = DetailedPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
        
        originalLanguage.text = translatedWordFromTable?.fromLanguage.title
        targetLanguage.text = translatedWordFromTable?.translateLanguage.title
        originalWord.text = translatedWordFromTable?.translated
        translatedWord.text = translatedWordFromTable?.result
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        presenter.saveTask()
        dismiss(animated: true)
    }
}

extension DetailedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func choosePictureButton(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let picture = UIAlertAction(title: "Picture", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(picture)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        translationImage = info[.editedImage] as? UIImage
        dismiss(animated: true)
    }
}

extension DetailedViewController: DetailedView {
    
    func getOriginalLanguage() -> String? {
        if let word = translatedWordFromTable?.fromLanguage.title {
            return word
        } else {
            return ""
        }
    }
    
    func getTargetLanguage() -> String? {
        if let word = translatedWordFromTable?.translateLanguage.title{
            return word
        } else {
            return ""
        }
    }
    
    func getOriginalWord() -> String? {
        if let word = translatedWordFromTable?.translated {
            return word
        } else {
            return ""
        }
    }
    
    func getTranslatedWord() -> String? {
        if let word = translatedWordFromTable?.result {
            return word
        } else {
            return ""
        }
    }
    
    func getTranslationImage() -> Data? {
        if let image = translationImage {
            return image.pngData()
        } else {
            return nil
            
        }
    }
}


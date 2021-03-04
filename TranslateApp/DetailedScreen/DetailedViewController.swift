
import UIKit

protocol DetailedView: class {
    func getOriginalLanguage() -> String
    func getTargetLanguage() -> String
    func getOriginalWord() -> String
    func getTranslatedWord() -> String
    func getTranslationImage() -> Data
}

class DetailedViewController: UIViewController {
    
//    вынести в презентер
    internal var translatedWordFromTable: TranslateResult!
    
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
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
//        в презентор
        originalLanguage.text = translatedWordFromTable?.fromLanguage.title
        targetLanguage.text = translatedWordFromTable?.translateLanguage.title
        originalWord.text = translatedWordFromTable?.translated
        translatedWord.text = translatedWordFromTable?.result
    }
    
    @IBAction private func saveButton(_ sender: UIButton) {
        presenter.saveTask()
        dismiss(animated: true)
    }
}

//MARK: - action controler setup
extension DetailedViewController: UIImagePickerControllerDelegate {
    
    @IBAction private func choosePictureButton(_ sender: UIButton) {
        
        let picture = UIAlertAction(title: "Picture", style: .default) { [self] _ in
            chooseImagePicker(source: .photoLibrary)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { [self] _ in
            chooseImagePicker(source: .camera)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        setupAction(style: .actionSheet, firstAction: picture, secondAction: camera, cancelAction: cancel)
    }
}

//MARK: - image picker setup
extension DetailedViewController: UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = source
        present(imagePicker, animated: true)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        translationImage = info[.editedImage] as? UIImage
        dismiss(animated: true)
    }
}

extension DetailedViewController: DetailedView {
    
    internal func getOriginalLanguage() -> String {
        translatedWordFromTable.fromLanguage.title
    }
    
    internal func getTargetLanguage() -> String {
        translatedWordFromTable.translateLanguage.title
    }
    
    internal func getOriginalWord() -> String {
        translatedWordFromTable.translated
    }
    
    internal  func getTranslatedWord() -> String {
        translatedWordFromTable.result
    }
    
    internal  func getTranslationImage() -> Data {
        translationImage!.pngData()!
    }
}

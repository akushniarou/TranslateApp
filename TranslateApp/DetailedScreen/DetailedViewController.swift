
import UIKit

protocol DetailedView: class {
    var originalLanguage: UILabel! { get }
    var targetLanguage: UILabel! { get }
    var originalWord: UILabel! { get }
    var translatedWord: UILabel! { get }
    func getOriginalLanguage() -> String
    func getTargetLanguage() -> String
    func getOriginalWord() -> String
    func getTranslatedWord() -> String
    func getTranslationImage() -> Data
}

class DetailedViewController: UIViewController {
    
    @IBOutlet internal weak var originalLanguage: UILabel!
    @IBOutlet internal weak var targetLanguage: UILabel!
    @IBOutlet internal weak var originalWord: UILabel!
    @IBOutlet internal weak var translatedWord: UILabel!
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
    
    internal var presenter: DetailedViewPresenter = DetailedPresenter()
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
        presenter.setCellColumns()
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
        presenter.translatedWordFromTable.fromLanguage.title
    }
    
    internal func getTargetLanguage() -> String {
        presenter.translatedWordFromTable.translateLanguage.title
    }
    
    internal func getOriginalWord() -> String {
        presenter.translatedWordFromTable.translated
    }
    
    internal  func getTranslatedWord() -> String {
        presenter.translatedWordFromTable.result
    }
    
    internal  func getTranslationImage() -> Data {
        translationImage!.pngData()!
    }
}

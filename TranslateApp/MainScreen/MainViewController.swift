
import UIKit

protocol MainView: class {
    func reloadData()
    
    func didUpdateState(_ state: MainPresenter.State)
    func getTextForTranslation() -> String
}

class MainViewController: UIViewController {
    
    private var presenter: MainViewPresenter = MainPresenter()
    private var selectedCellContent: TranslateResult?
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputField: UITextField!
    @IBOutlet private weak var languagePickerFrom: UIPickerView!
    @IBOutlet private weak var languagePickerTo: UIPickerView!
    
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailedViewController {
            
            controller.translatedWordFromTable = selectedCellContent
        }
    }
    
    @IBAction private func getTranslation(_ sender: Any) {
        presenter.getTranslation()
    }
}

extension MainViewController: MainView {
    
    func didUpdateState(_ state: MainPresenter.State) {
        switch state {
        case .normal:
            self.tableView.backgroundView = nil
        case .loading:
            let activity = UIActivityIndicatorView(style: .large)
            activity.startAnimating()
            activity.color = .orange
            tableView.backgroundView = activity
        case .error(let error):
            let label = UILabel(frame: tableView.bounds)
            label.text = error
            label.textAlignment = .center
            label.textColor = .red
            tableView.backgroundView = label
            print(error)
        }
    }
    
    internal func getTextForTranslation() -> String {
        return inputField.text?.lowercased() ?? ""
    }
    
    internal func reloadData() {
        tableView.reloadData()
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
}

//MARK: - tableView settings
extension MainViewController: UITableViewDataSource {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTranslationData().count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.getTranslationData()[indexPath.row].result
        return cell
    }
}

//MARK: - content from selected cell
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCellContent = presenter.getTranslationData()[indexPath.row]
        performSegue(withIdentifier: "toDetailedView", sender: self)
    }
}

//MARK: - pickerView settings
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getAllLanguages().count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getAllLanguages()[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == languagePickerFrom {
            presenter.setOriginal(language: presenter.getAllLanguages()[row])
        } else {
            presenter.setTarget(language: presenter.getAllLanguages()[row])
            
        }
    }
}

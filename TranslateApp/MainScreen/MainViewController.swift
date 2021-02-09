
import UIKit

protocol MainView: class {
    func reloadData()
    
    func didUpdateState(_ state: MainPresenter.State)
    func getTextForTranslation() -> String
    func getTableView() -> UITableView
}

class MainViewController: UIViewController {
    
    private var presenter: MainViewPresenter = MainPresenter()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputField: UITextField!
    @IBOutlet private weak var languagePickerFrom: UIPickerView!
    @IBOutlet private weak var languagePickerTo: UIPickerView!
    
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
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
            print(error)
        }
    }
    
    internal func getTextForTranslation() -> String {
        return inputField.text ?? ""
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
        return presenter.getArrayOfTranslatedWords().count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.getArrayOfTranslatedWords()[indexPath.row]
        return cell
    }
}

//MARK: - pickerView settings
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getLanguages().count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getLanguages()[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == languagePickerFrom {
            presenter.setPickerFromValue(value: presenter.getLanguages()[row])
        } else {
            presenter.setPickerToValue(value: presenter.getLanguages()[row])

        }
    }
}

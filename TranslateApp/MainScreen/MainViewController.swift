
import UIKit

protocol MainView: class {
    func reloadData()
    
    func didUpdateState(_ state: MainPresenter.State)
    func getTextForTranslation() -> String
}

class MainViewController: UIViewController {
    
    private var presenter: MainViewPresenter = MainPresenter()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inputField: UITextField!
    @IBOutlet private weak var languagePickerFrom: ChoosePickerView!
    @IBOutlet private weak var languagePickerTo: ChoosePickerView!
    
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
        hideKeyboardWhenTappedAround()
        languagePickerFrom.setData(presenter.getAllLanguages())
        languagePickerFrom.didSelectAction = { [ weak self ] selected in
            self?.presenter.setOriginal(language: selected)
        }
        languagePickerTo.setData(presenter.getAllLanguages())
        languagePickerTo.didSelectAction = { [ weak self ] selected in
            self?.presenter.setTarget(language: selected)
        }
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailedViewController {
            
            controller.translatedWordFromTable = presenter.selectedCellContent
        }
    }
    
    @IBAction private func getTranslation(_ sender: Any) {
        presenter.getTranslation()
    }
}

extension MainViewController: MainView {
    
    internal func didUpdateState(_ state: MainPresenter.State) {
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
    
    private func getTableView() -> UITableView {
        return tableView
    }
}

//MARK: - tableView settings
extension MainViewController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfTranslations()
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter.getTranslationData()[indexPath.row].result
        return cell
    }
}

//MARK: - content from selected cell
extension MainViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.setSelected(index: indexPath.row)
        performSegue(withIdentifier: "toDetailedView", sender: self)
    }
}



import UIKit
import CoreData

protocol SaveCardView: class {
}

class SavedCardController: UITableViewController {
    
    private var presenter: SavedCardPresenter = SavedPresenter()
    
    override internal func loadView() {
        super.loadView()
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
    }
}

extension SavedCardController: SaveCardView {
}

//MARK: - TableView settings
extension SavedCardController {
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getObjectsCount()
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCardCell", for: indexPath) as! SavedCardCell
        
        let task = presenter.getTaskByRow(row: indexPath.row)
        
        cell.originalLanguage.text = task.originalLanguage
        cell.originalWord.text = task.enteredWord
        cell.targetLanguage.text = task.targetLanguage
        cell.translatedWord.text = task.translatedWord
//        хранить в файл менеджере и передавать только путь
        cell.explanatoryPicture.image = UIImage(data: task.picture)
        
        return cell
    }
    
    override internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.removeCard(row: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

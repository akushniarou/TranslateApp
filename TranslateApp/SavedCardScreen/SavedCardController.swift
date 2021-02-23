
import UIKit
import CoreData

protocol SaveCardView: class {
    func getCell() -> UITableViewCell
    
}

class SavedCardController: UITableViewController {
    
    private var presenter: SavedCardPresenter = SavedPresenter()
    private var tasks = [Task]()
    private var cells =  SavedCardCell()
    
    override func loadView() {
        super.loadView()
        tasks = presenter.getObjects()
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
    }
}

extension SavedCardController: SaveCardView {
    func getCell() -> UITableViewCell {
        return cells
    }
}

//MARK: - TableView settings
extension SavedCardController {
    
    override internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCardCell", for: indexPath) as! SavedCardCell
        
        let task = tasks[indexPath.row]
        
        cell.originalLanguage.text = task.originalLanguage
        cell.originalWord.text = task.enteredWord
        cell.targetLanguage.text = task.targetLanguage
        cell.translatedWord.text = task.translatedWord
        cell.explanatoryPicture.image = UIImage(data: task.picture!)
        
        return cell
    }
}

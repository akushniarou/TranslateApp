
import UIKit

protocol SaveCardView: class {
    
}

class SavedCardController: UITableViewController {
    
    private var presenter: SavedCardPresenter = SavedPresenter()
    
    private var tasks = [String]()
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
    }
    
    @IBAction private func getBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SavedCardController: SaveCardView {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCardCell", for: indexPath) as UITableViewCell
        
        return cell
    }
}

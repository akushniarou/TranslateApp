
import UIKit

protocol DetailedView: class {
    
}

class DetailedViewController: UIViewController {
    
    private var presenter: DetailedViewPresenter = DetailedPresenter()
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        presenter.addView(view: self)
    }
    
    @IBAction private func getBack(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension DetailedViewController: DetailedView {
    
}

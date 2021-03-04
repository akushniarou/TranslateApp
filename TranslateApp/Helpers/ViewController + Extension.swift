
import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

//
    func setupAction(title: String? = nil, message: String? = nil, style: UIAlertController.Style, firstAction: UIAlertAction?, secondAction: UIAlertAction?, cancelAction: UIAlertAction) {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let action = firstAction {
            actionSheet.addAction(action)
        }
        
        if let action = secondAction {
            actionSheet.addAction(action)
        }
        
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
}

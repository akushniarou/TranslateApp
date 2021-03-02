
import UIKit

class ChoosePickerView: UIView {
    
    private var data = [String]()
    var didSelectAction: ((String) -> Void)?
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView.init()
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(self.pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pickerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func setData(_ arr: [String]) {
        self.data = arr
        self.pickerView.reloadComponent(0)
    }
}

extension ChoosePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let result = self.data[row]
        didSelectAction?(result)
    }
}

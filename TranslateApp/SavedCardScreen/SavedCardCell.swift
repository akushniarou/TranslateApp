
import UIKit

class SavedCardCell: UITableViewCell {

    @IBOutlet weak var originalLanguage: UILabel!
    @IBOutlet weak var targetLanguage: UILabel!
    @IBOutlet weak var originalWord: UILabel!
    @IBOutlet weak var translatedWord: UILabel!
    @IBOutlet weak var explanatoryPicture: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

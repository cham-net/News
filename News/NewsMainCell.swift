import UIKit

class NewsMainCell: UITableViewCell {
    
    @IBOutlet weak var mainLabelTitle: UILabel!
    @IBOutlet weak var mainLabelText: UILabel!
    @IBOutlet weak var mainLabelDate: UILabel!
    @IBOutlet weak var fButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
      func setup(with newsApi: News) {
        mainLabelTitle.text = newsApi.title
        mainLabelText.text = newsApi.text
        mainLabelDate.text = newsApi.date.string
    }
    

    
    
    
    
    
    
}

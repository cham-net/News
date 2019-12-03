import UIKit

class NewsFavoriteCell: UITableViewCell {
    
    @IBOutlet weak var favoriteLabelTitle: UILabel!
    @IBOutlet weak var favoriteLabelText: UILabel!
    @IBOutlet weak var favoriteLabelDate: UILabel!
    
    var newss: News? {
      didSet {
        guard let news = newss else { return }
              favoriteLabelTitle.text = news.title
              favoriteLabelText.text = news.text
              favoriteLabelDate.text = news.date.string
      }
    }
    
    
    func setup(with news: News) {
        favoriteLabelTitle.text = news.title
        favoriteLabelText.text = news.text
        favoriteLabelDate.text = news.date.string
    }
    
}

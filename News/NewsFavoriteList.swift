import UIKit
import RealmSwift

class NewsFavoriteList: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [News]()
    var realmItems: Results<News>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        self.realmItems = realm.objects(News.self)
    }

}

extension NewsFavoriteList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmItems.isEmpty ? 1 : realmItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if realmItems.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "")
            cell.textLabel?.text = "У вас нет сохраненных новостей."
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            cell.textLabel?.textColor = .systemGray3
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! NewsFavoriteCell
        cell.setup(with: realmItems[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
        let realm = try! Realm()
        let delRealmItems = realmItems[indexPath.row]
        try! realm.write {
          realm.delete(delRealmItems)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

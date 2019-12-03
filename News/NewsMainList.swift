import UIKit
import Closures
import RealmSwift

class NewsMainList: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var alert: UIAlertController!
    var addAction: UIAlertAction!
    
    var news = [News]() {
          didSet {
              tableView.reloadData()
          }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let title = "При стрельбе в Новом Орлеане пострадали 11 человек"
//        let text = "В результате стрельбы в американском городе Новый Орлеан в штате Луизиана пострадали 11 человек, двое из них находятся в критическом состоянии. Об этом сообщает NBC со ссылкой на полицию. В полиции сообщили, что пока никто не задержан, мотивы стрельбы устанавливаются."
//        API.createNews(title: title, text: text) {
//            result in guard result else { return }
//        }
        API.loadNews { notesArray in
            self.news = notesArray
        }
    }


}

extension NewsMainList: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! NewsMainCell
        cell.setup(with: news[indexPath.row])
        cell.fButton.onTap {
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoryboardID") as! NewsFavoriteList
            //vc.items = [self.news[indexPath.row]]
            let realm = try! Realm()
            try! realm.write {
                realm.add(self.news[indexPath.row])
            }
            self.alert = UIAlertController(title: "Готово!", message: "Вы добавили эту новость в закладки! Вы можете снова вернуться к этой новости через меню.", preferredStyle: .alert)
            self.alert.addAction(UIAlertAction(title: "Ясненько :)", style: .cancel))
            self.present(self.alert, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }

}



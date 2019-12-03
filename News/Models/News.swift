import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var text: String?
    @objc dynamic var date: Date = Date()
    
    convenience init(id: String, data: JSON) {
        self.init()
        self.id = id
        self.title = data["title"] as? String
        self.text = data["text"] as? String
        self.date = (data["date"] as! String).date
    }
    
}

import Foundation

typealias JSON = [String : Any]

enum API {

  static var identifier: String { "TEST10" }

  static var baseURL: String {
      "https://ios-napoleonit.firebaseio.com/data/\(identifier)/"
  }

  static var storageName: String { "news" }

  static func loadNews(completion: @escaping ([News]) -> Void) {
    let url = URL(string: baseURL + ".json")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard
            let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON
        else { return }
    let newsJSON = json[storageName] as! JSON
    var news = [News]()
    for newss in newsJSON {
        news.append(News(id: newss.key, data: newss.value as! JSON))
    }
        
    news.sort { $0.date > $1.date }
        
    DispatchQueue.main.async {
        completion(news)
        }
    }
  task.resume()
  }

static func createNews(title: String, text: String, completion: @escaping (Bool) -> Void) {
    let params = [
        "title": title,
        "text": text,
        "date": Date().string
    ]
    let url = URL(string: baseURL + "/\(storageName).json")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try? JSONSerialization.data(withJSONObject: params)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        completion(error == nil)
        }
    task.resume()
    }
}

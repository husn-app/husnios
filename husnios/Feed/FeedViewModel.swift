
import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var products: [Product] = []
    private let server = "https://husn-dev.azurewebsites.net"
    
    func fetchFeedProducts() {
        let url = URL(string: "\(server)/api/feed")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                do {
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    // print(String(data: data, encoding: .utf8))
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let productsListJson = json["products"] as! [[String:Any]]
                    self.products = productsListJson.map { Product(json: $0) }
                }
            }
        }
        task.resume()
    }
}

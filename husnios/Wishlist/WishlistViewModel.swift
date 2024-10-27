import Foundation
import Combine

class WishlistViewModel: ObservableObject {
    @Published var wishlisted_products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWishlistedProducts() {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/wishlist")
        
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
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let productsListJson = json["products"] as! [[String: Any]]
                    self.wishlisted_products = productsListJson.map { Product(json: $0) }
                }
            }
        }
        task.resume()
    }
}

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    private var currentPage = 1
    private let pageSize = 16 // Number of products per page

    func fetchFeedProducts() {
        fetchMoreFeedProducts()
    }

    func fetchMoreFeedProducts() {
        guard !isLoading else { return } // Prevent multiple requests
        isLoading = true

        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/feed")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["num_products": "\(pageSize)", "page": "\(currentPage)"] // Add page parameter
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false // Stop loading indicator
                do {
                    if let error = error {
                        print(error)
                        return
                    }

                    guard let data = data else {
                        print("No data received")
                        return
                    }

                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let productsListJson = json["products"] as! [[String: Any]]
                    let newProducts = productsListJson.map { Product(json: $0) }

                    self.products.append(contentsOf: newProducts)  // Append new products
                    self.currentPage += 1  // Increment page number
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        task.resume()
    }
    
    func shouldLoadMore(_ currentItemIndex: Int) -> Bool {
        // Preload before the user reaches the end
        return currentItemIndex + 1 < Config.MAX_PRODUCTS_IN_FEED && currentItemIndex == products.count - 6 && !isLoading
    }
}

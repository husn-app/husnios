import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var product: Product = Product()
    @Published var similarProducts: [Product] = []

    func fetchProductDetails(product_id: Int, referrer: String) {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/product/\(product_id)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["referrer": "ios/\(referrer)"], options: [])
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let productJson = json["product"] as! [String: Any]
                        let similarProductsJsonList = json["similar_products"] as! [[String: Any]]
                        
                        self.product = Product(json: productJson)
                        self.similarProducts = similarProductsJsonList.map { Product(json: $0) }
                    } catch {
                        print("Failed to parse JSON")
                        print("Data received: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                    }
                }
            }
        }
        task.resume()
    }
}

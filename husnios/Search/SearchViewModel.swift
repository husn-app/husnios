import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var products: [Product] = []

    
    func fetchProductDetails(query: String) {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/query")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["query": query], options: [])
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
                        let productsListJson = json["products"] as! [[String:Any]]
                        self.products = productsListJson.map { Product(json: $0) }
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

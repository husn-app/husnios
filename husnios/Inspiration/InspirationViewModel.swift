let sampleInspiration = Inspiration(
    category: "Sample Category",
    products: Array(repeating: sampleProduct, count: 8)
)

let sampleInspirations = Array(repeating: sampleInspiration, count: 12)

import Foundation
import Combine

class InspirationViewModel: ObservableObject {
    @Published var inspirations: [Inspiration] = []
    private var cancellables = Set<AnyCancellable>()
    private let server = "https://husn-dev.azurewebsites.net"
    
    func fetchInspirations() {
        let url = URL(string: "\(server)/api/inspiration")
        
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
                    let inspirationsJson = json["inspirations"] as! [[String: Any]]
                    self.inspirations = inspirationsJson.map { Inspiration(json: $0) }
                }
            }
        }
        task.resume()
    }
}
